# ********* SECTION IMPORTATION *******
import os, random
from flask import Flask, request
from threading import Thread
from conf import ACCESS_TOKEN
from messenger import Messenger
from fnmatch import fnmatch
import requests

# **************************************


# ********* SECTION INSTANCIATION ******

VERIFY_TOKEN = 'jedeconne'

app = Flask(__name__)
bot = Messenger(ACCESS_TOKEN)

# **************************************


@app.route("/", methods=['GET', 'POST'])
def receive_message():
    '''
        Route andefasany Facebook requete amntsika 
    '''
    if request.method == 'GET':
        # Mandefa GET izy ra iverifier hoe mande ve le serveur
        token_sent = request.args.get("hub.verify_token")
        return verify_fb_token(token_sent)

    elif request.method == "POST":
        # akato ndreka izy mandefa an le message tonga amn page iny mits
        # recuperena le json nalefany facebook 
        body = request.get_json()
        # alefa any amn processus afa manao azy 
        run = Analyse(body)
        # tsy mila miandry an le Analyse vita fa  lasa le code
        run.start()

    return "Voray ry Facebook fa Misoatra a!", 200


def verify_fb_token(token_sent):
    if token_sent == VERIFY_TOKEN:
        return request.args.get("hub.challenge")
    return 'Diso ooo'


class Analyse(Thread):
    def __init__(self, body):
        Thread.__init__(self)
        self.body = body
    
    def run(self):
        for event in self.body['entry']:
            messaging = event['messaging']
            for message in messaging:

                if message.get('message'):
                    senderID = message['sender']['id']
                    
                    if message['message'].get('quick_reply'):
                        traitement(senderID, message['message'].get('quick_reply').get('payload'))

                    elif message['message'].get('text'):
                        traitement(senderID, message['message'].get('text'))
                    
                elif message.get('postback'):
                    senderID = message['sender']['id']
                    pst_title = message['postback']['title']
                    pst_payload = message['postback']['payload']

                    traitement(senderID, pst_payload)

        

def traitement(senderID, message):

    ''' 
        ATO ZAO NY FONCTION TENA IASA 
        SATRIA NO MANAO TRAITEMENT ISIKA
    '''

    message = message.strip()
    statut = req.getAction(senderID)

    if message in range(8):
        bot.send_action(senderID, 'mark_seen')
        bot.send_action(senderID, 'typing_on')

        bot.send_result(senderID, message)
        
        pload = {
            "user_id": 2,
            "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MzIyOTkzOTcsInN1YiI6Mn0.B4CFRpZBPyFXN7I2nG3eovl0Z2o0MZaKcJmva7WEuws"
        }
        
        contents = requests.post("http://0.0.0.0:4444/api/v1/get_content/", data=pload)

    else:
        bot.send_message(senderID, "Aucun element disponible dans cette ")

        bot.send_action(senderID, 'typing_off')
        return

    if message == '':
        bot.send_action(senderID, 'mark_seen')
        bot.send_action(senderID, 'typing_on')
        bot.send_message(senderID, "Saisir votre recherche")
        bot.send_action(senderID, 'typing_off')

        return

    elif message.startswith('LISTE'):
        if fnmatch(message, '*--page=*'):
            message = message.replace('--page=', '')
            mes = message.split()
            message = ' '.join(mes[:-1])
            page = int(mes[-1])
        else:
            page = 1
        print(page)
        res = req.produits()
        bot.send_action(senderID, 'mark_seen')
        bot.send_action(senderID, 'typing_on')
        if len(res) > 0:
            if len(res) - page*10 > 0:
                next =  [
                    {
                        "content_type":"text",
                        "title":"Page Suivante",
                        "payload":f"LISTE --page={page+1}",
                        "image_url":"https://icon-icons.com/downloadimage.php?id=81300&root=1149/PNG/512/&file=1486504364-chapter-controls-forward-play-music-player-video-player-next_81300.png"
                    }
                ]
            else:
                next = None 
            bot.send_result(senderID, res, page, next=next)
        else:
            bot.send_message(senderID, "Aucun element disponibl")
        return


if __name__ == '__main__':
    app.run(port=6000)
