"""Translates text into the target language.

Make sure your project is whitelisted.

Target must be an ISO 639-1 language code.
See https://g.co/cloud/translate/v2/translate-reference#supported_languages
"""
from google.cloud import translate_v2 as translate
import os
credential_path = "C:/pvr/translation/html/google-account/GoogleKey.json"
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = credential_path
target = 'gu'
translate_client = translate.Client()
text = "Hello, how are you?"
text = open("Lecture_en.txt", "r", encoding="utf-8", errors='ignore').read()
#output=[]

text_file=open("Output.txt", "w", encoding="utf-8")

for line in text.splitlines():
       # For Python3, use print(line)
       result = translate_client.translate(
       line, target_language=target, model="base")
 #      output.append(result['translatedText'])
       text_file.write(result['translatedText'] + "\n")  
       
#MyFile=open("Output.txt", "w", encoding="utf-8")
#MyFile.writelines(output)
#MyFile.close()       
#with open("Output.txt", "w", encoding="utf-8" , errors='ignore') as text_file:
#    for i in output:
#        text_file.write(i + "\n")   
# Text can also be a sequence of strings, in which case this method
# will return a sequence of results for each text.

'''
print(u'Text: {}'.format(result['input']))
print(u'Translation: {}'.format(result['translatedText']))
print(u'Detected source language: {}'.format(
    result['detectedSourceLanguage']))
'''


