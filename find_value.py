
import requests

link = 'https://economia.awesomeapi.com.br/json/last/USD-BRLPTAX?token=da63e27db5a65f572a526138a343c51ee95989e7736c2297c6bda71c946a79b0'

request = requests.get(link)
cotacao = request.json()['USDBRLPTAX']['bid']



