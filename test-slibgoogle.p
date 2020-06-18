/**
 * test-slibgoogle.p -
 *
 * (c) Copyright ABC Alon Blich Consulting Tech, Ltd.
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program. If not, see .
 *
 *  Contact information
 *  Email: alonblich@gmail.com
 *  Phone: +972-54-218-8086
 */

{slib/slibgoogle.i}

define var str as char no-undo.



/*
Language                Language code
--------                -------------
Afrikaans               af
Albanian                sq
Arabic 	                ar
Belarusian              be
Bulgarian               bg
Catalan                 ca
Chinese Simplified      zh-CN
Chinese Traditional     zh-TW
Croatian                hr
Czech                   cs
Danish                  da
Dutch                   nl
English                 en
Estonian                et
Filipino                tl
Finnish                 fi
French                  fr
Galician                gl
German                  de
Greek                   el
Haitian Creole          ht
Hebrew                  iw
Hindi                   hi
Hungarian               hu
Icelandic               is
Indonesian              id
Irish                   ga
Italian                 it
Japanese                ja
Latvian                 lv
Lithuanian              lt
Macedonian              mk
Malay                   ms
Maltese                 mt
Norwegian               no
Persian                 fa
Polish                  pl
Portuguese              pt
Romanian                ro
Russian                 ru
Serbian                 sr
Slovak                  sk
Slovenian               sl
Spanish                 es
Swahili                 sw
Swedish                 sv
Thai                    th
Turkish                 tr
Ukrainian               uk
Vietnamese              vi
Welsh                   cy
Yiddish                 yi
*/

run google_translate(
    input   "en",
    input   "Customer Name",
    input   "de",
    output  str ).

message str view-as alert-box.
