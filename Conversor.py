from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtGui import QGuiApplication
from PySide6.QtCore import QObject, Slot,QUrl
from find_value import cotacao

def eh_digito(str):
    try:
        float(str)
        return True
    except:
        return False
def formata(str):
    nova_string = str.replace(',','.')
    return nova_string
class Backend(QObject):
    @Slot(str,result=str)
    def converte_Real_para_Dolar(self,valor):
        valor = formata(valor)
        if valor and eh_digito(valor):
            resultado = (float(valor) * (1/float(cotacao)))
            resultado_2casas = f'{resultado:.2f}'
            output = str(resultado_2casas).replace('.',',')
            
            return output
        elif valor == '':
            return ''
        else:
            return 'ERROR'
        
    @Slot(str,result=str)
    def converte_Dolar_para_Real(self,valor):
        valor = formata(valor)
        if valor and eh_digito(valor):
            resultado = (float(valor) * float(cotacao))
            resultado_2casas = f'{resultado:.2f}'
            output = str(resultado_2casas).replace('.',',')
            return output
        elif valor == '':
            return ''
        else:
            return 'ERROR'
    @Slot(result=bool)   
    def animation_condition(self):
        if cotacao:
            return True
        else:
            return False  
    @Slot(result=str)
    def verifica(self):
        if cotacao:
            return 'Cotação atualizada!'
        else:
            return 'ERRO!'
    @Slot(result=str)    
    def value_notification(self):
        if cotacao:
            return f'Dolar atual: {float(cotacao):.4f} Reais'
        else:
            return f'Erro ao atualizar o valor'


if __name__ == '__main__':
    app = QGuiApplication()
    engine = QQmlApplicationEngine()
    backend = Backend()
    engine.rootContext().setContextProperty("backend", backend)
    # engine.load('usando_qml.qml')
    engine.load(QUrl.fromLocalFile('interface.qml'))


    app.exec()