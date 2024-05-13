
import requests
from bs4 import BeautifulSoup

link = 'https://www.google.com/search?q=cota%C3%A7%C3%A3o+atual+dolar+hoje'
headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36'}

requisicao = requests.get(link,headers=headers)
soup = BeautifulSoup(requisicao.text,'html.parser')
cotacao = soup.find('span',class_='SwHCTb')
cotacao = cotacao['data-value']
