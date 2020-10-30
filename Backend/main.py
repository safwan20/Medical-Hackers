from flask import Flask, request
from pred import predictBeat
import os
from werkzeug.utils import secure_filename
import base64

app = Flask(__name__)

app.config['UPLOAD_FOLDER'] = 'yes'

@app.route('/', methods=['GET','POST'])
def home() :
    if request.method == 'POST' :
        # audio = request.files['file']
        # audio.save(audio.filename)
        # signal = audio.filename.replace('.hea',"") 
        # print(signal)
        # predictBeat(signal)

        print(":HELOEH")


        audio_files = request.files.getlist('file[]')

        for audio in audio_files :
            print(audio)
            if 'hea' in audio.filename :
                signal = audio.filename.replace('.hea',"") 
            audio.save(audio.filename)
        pred = predictBeat(signal)

    return pred


@app.route('/show_image',methods=['GET','POST'])
def show_image() :
    with open("images\pie.jpg", "rb") as image_file:
        encoded_strings = base64.b64encode(image_file.read())
    
    return encoded_strings


app.run(host='192.168.1.107')