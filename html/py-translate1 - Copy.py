"""Translates text into the target language.

Example commandline

python py-translate1.py -input lecture_hi.txt -output lecture_gu1.txt -target_lang gu -source_lang hi
"""
from google.cloud import translate_v2 as translate
import os
import sys
import argparse


parser = argparse.ArgumentParser()
parser._action_groups.pop()
required = parser.add_argument_group('required arguments')

required.add_argument("-input",  required=True)
required.add_argument("-output",required=True)
required.add_argument("-target_lang",  required=True)
required.add_argument("-source_lang",  required=False,default='en')
required.add_argument("-model",  required=False,default='base')

args = parser.parse_args()

credential_path = "C:/pvr/translation/html/google-account/GoogleKey.json"
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = credential_path
translate_client = translate.Client()

input_text = open(args.input, "r", encoding="utf-8", errors='ignore').read()
output_file=open(args.output, "w", encoding="utf-8", errors='ignore')

for line in input_text.splitlines():
       result = translate_client.translate(line,source_language=args.source_lang, target_language=args.target_lang, model=args.model)
       output_file.write(result['translatedText'] + "\n")  
       


