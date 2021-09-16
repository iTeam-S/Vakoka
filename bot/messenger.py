import requests

class Messenger:
    def __init__(self, access_token):
        self.token = access_token
        self.url = "https://graph.facebook.com/v8.0/me"


    def send_message(self, destId, message, prio=False):
        '''
            Cette fonction sert à envoyer une message texte
                à l'utilisateur en vue de répondre à un message
                                                                '''
        dataJSON = {
            'recipient':{
                "id": destId
            },

            'message':{
                "text": message
            }
        }

        if prio:
            dataJSON["messaging_type"] = "MESSAGE_TAG"
            dataJSON["tag"] = "ACCOUNT_UPDATE"

        header = {'content-type' : 'application/json; charset=utf-8'}
        params = {"access_token" : self.token}

        return requests.post(self.url + '/messages', json=dataJSON, headers=header, params=params)
    

    def send_action(self, destId, action):
        '''
            action doit etre un des suivants ['mark_seen', 'typing_on', 'typing_off']
        '''
        if action not in ['mark_seen', 'typing_on', 'typing_off']:
            return None

        dataJSON = {
            'messaging_type': "RESPONSE",
            'recipient':{
                "id": destId
            },

            'sender_action': action
        }

        header = {'content-type' : 'application/json; charset=utf-8'}
        params = {"access_token" : self.token}

        return requests.post(self.url + '/messages', json=dataJSON, headers=header, params=params)
    

    def send_quick_reply(self, destId, **kwargs):
        if kwargs.get('MENU_PRINCIPALE'):
            categories = [
                "Zavaboary Malagasy", "Mombamomba ny fokonolona",
                "Fahizana nentimpaharazana", "Fitsaboana nentipaharazana",
                "Fananana arakolotsaina", "Tantara sy fomba ny faritra",
                "Toekarena sy socialim-pirenena", "Lalana sy Dina"
            ]

            text = 'Salama tompoko ! Safidio izay sokajy tianao hojerena .'
            quick_rep = [
                {
                    "content_type":"text",
                    "title": category,
                    "payload": categories.index(category),
                    "image_url" : "https://img.icons8.com/ios-filled/50/000000/book.png"
                } for category in categories
            ]

        else:
            return 

        dataJSON = {
            'messaging_type': "RESPONSE",
            'recipient':{
                "id": destId
            },

            'message': {
                'text' : text,
                'quick_replies': quick_rep
            }
        }

        header = {'content-type' : 'application/json; charset=utf-8'}
        params = {"access_token" : self.token}

        return requests.post(self.url + '/messages', json=dataJSON, headers=header, params=params)


    def send_result(self, destId, elements, **kwargs):
        elem = [
            {
                "title": f"{media[0]} - {media[1]}",
                "image_url": "https://img.icons8.com/ios-filled/50/000000/book.png",
                "subtitle": f"Prix: {media[2]} Ar\nDisponible: {media[3]}",
                "buttons": [
                    {
                        "type":"postback",
                        "title":"Commander",
                        "payload": f"COMMANDER {media[0]} \nou\n {media[1]}"
                    },
                ]
            } 
            for media in elements[(pg-1)*10 : pg*10]
        ]

        dataJSON = {
            'messaging_type': "RESPONSE",
            'recipient':{
                "id": destId
            },
            'message' : {
                "attachment":{
                    "type":"template",
                    "payload":{
                        "template_type":"generic",
                        "elements": elem
                    },
                },
                
            }
        }

        if kwargs.get("next"):
            dataJSON['message']['quick_replies'] = kwargs.get("next")

        header = {'content-type' : 'application/json; charset=utf-8'}
        params = {"access_token" : self.token}

        return requests.post(self.url + '/messages', json=dataJSON, headers=header, params=params)