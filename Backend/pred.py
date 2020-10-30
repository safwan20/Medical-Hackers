import matplotlib.pyplot
import numpy as np
import os
import wfdb
import pickle
from collections import Counter
import scipy
from sklearn.preprocessing import scale
import pandas as pd
from statsmodels.tsa.stattools import levinson_durbin
import peakutils
from peakutils.plot import plot as pplot

model_path = "MIT.sav"
clf = pickle.load(open(model_path, 'rb'))

ans = dict()

len_qrs = 40
len_stt = 120
autoreg_ord = 9

def predictBeat(signal):
    try_signal, _ = wfdb.rdsamp(signal, channels=[0], sampfrom=0, sampto=9000)
    try_signal = try_signal.flatten()
    indexes = peakutils.indexes(try_signal, thres=0.5, min_dist=30)
    
    a, b = scipy.signal.butter(3, 1/180, btype='highpass', analog=True)
    fil1 = scipy.signal.lfilter(b, a, try_signal)
    c, d = scipy.signal.butter(3, [58/180, 62/180], btype='bandstop', analog=True)
    fil2 = scipy.signal.lfilter(d, c, fil1)
    e, f = scipy.signal.butter(4, 25/180, btype='lowpass', analog=True)
    filtered = scipy.signal.lfilter(f, e, fil2)
    minutes = (len(filtered)/(360*60))
    heart_rate = len(indexes)/minutes
    globalList = list()
    for i in range(len(indexes)):
        to_append = list()
        r_peak = indexes[i]
        qrs_start = r_peak - int(len_qrs/2) + 1

        qrs_segment = filtered[qrs_start: qrs_start + len_qrs]
        stt_segment = filtered[qrs_start + len_qrs +
                            1: qrs_start + len_qrs + len_stt]



        if len(qrs_segment) > 0:
            _, qrs_arcoeffs, _, _, _ = levinson_durbin(
                qrs_segment, nlags=autoreg_ord, isacov=False)
        else:
            qrs_arcoeffs = ['nan']*9

        #AR Coefficients of STT
    
        if len(stt_segment) > 0:
            _, stt_arcoeffs, _, _, _ = levinson_durbin(
                stt_segment, nlags=autoreg_ord, isacov=False)
        else:
            stt_arcoeffs = ['nan']*9

    # Pre RR and Post RR length
        if i > 0:
            pre_rr = indexes[i] - indexes[i-1]
        else:
            pre_rr = None

        if i+1 < len(indexes):
            post_rr = indexes[i+1] - indexes[i]
        else:
            post_rr = None

        to_append.append(qrs_start)
        to_append.append(qrs_start + len_qrs + len_stt)
        to_append.append(pre_rr)
        to_append.append(post_rr)
        to_append.extend(qrs_arcoeffs)
        to_append.extend(stt_arcoeffs)
        if None not in to_append and 'nan' not in to_append:
            globalList.append(to_append)

    df = pd.DataFrame(globalList, columns=['start', 'end', 'pre_rr', 'post_rr', 'arqrs1', 'arqrs2', 'arqrs3', 'arqrs4', 'arqrs5',
                                           'arqrs6', 'arqrs7', 'arqrs8', 'arqrs9', 'arstt1', 'arstt2', 'arstt3', 'arstt4', 'arstt5', 'arstt6', 'arstt7', 'arstt8', 'arstt9'])
    test = df[['pre_rr', 'post_rr', 'arqrs1', 'arqrs2', 'arqrs3', 'arqrs4', 'arqrs5', 'arqrs6', 'arqrs7', 'arqrs8',
               'arqrs9', 'arstt1', 'arstt2', 'arstt3', 'arstt4', 'arstt5', 'arstt6', 'arstt7', 'arstt8', 'arstt9']]
    test = scale(test)
    predictions = clf.predict(test)
    predictions = list(predictions)
    pred_dict = dict(Counter(predictions))

    if 0 in pred_dict.keys():
        pred_dict['Normal'] = pred_dict.pop(0)
    if 1 in pred_dict.keys():
        pred_dict['Premature Beats'] = pred_dict.pop(1)
    if 2 in pred_dict.keys():
        pred_dict['Escape Beats'] = pred_dict.pop(2)
    if 3 in pred_dict.keys():
        pred_dict['Fusion Beats'] = pred_dict.pop(3)
    if 4 in pred_dict.keys():
        pred_dict['Unrecognized'] = pred_dict.pop(4)
    if 5 in pred_dict.keys():
        pred_dict['Bundled Branch Block Beat'] = pred_dict.pop(5)
        
    fig = matplotlib.pyplot.figure(figsize=(10, 7))
    matplotlib.pyplot.pie(pred_dict.values(),
                           labels=pred_dict.keys(), autopct='%1.0f%%')
    matplotlib.pyplot.savefig('images\pie.jpg', bbox_inches='tight')
    matplotlib.pyplot.close()
    
    for ind in df.index:
        if predictions[ind] != 0:    
            sig = filtered[df['start'][ind]:df['end'][ind]]
            matplotlib.pyplot.axis('off')
            matplotlib.pyplot.plot(sig)
            matplotlib.pyplot.savefig('images\\'+str(ind)+'.jpg', bbox_inches='tight')
            matplotlib.pyplot.close()
    keymax = max(pred_dict, key=pred_dict.get)
    print('Your maximum beats are: ', keymax)
    print ('Heart Rate: ', heart_rate)

    ans['beats'] = keymax
    ans['rate'] = int(heart_rate)

    return ans

# predictBeat(r"C:\Users\capnp\Desktop\Medical\ECG module\mit-bih-arrhythmia-database-1.0.0\119")
