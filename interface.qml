import QtQuick
import QtQuick.Controls.Material

ApplicationWindow{
    id: main_window
    Material.theme: 'Dark'
    visible: true
    width: 300
    height: 500
    minimumWidth: 300
    maximumWidth: 300
    minimumHeight: 500
    maximumHeight: 500

    font.pixelSize: 50
    title: 'Conversor'

    property var is_dolar: true
    

    Text {
        text: 'CONVERSOR'
        font.family: "Arial"       
        font.bold: true
        color: 'white'
        font.pointSize: 30
        anchors.horizontalCenter: parent.horizontalCenter
        y: 20
    }


    TextField {
        id: input
        width: 100
        height: 45
         // Define a largura do campo de texto
        placeholderText: "DOLAR"
         // Texto de dica
        font.pixelSize: 16
        anchors {
            rightMargin: 10
            verticalCenter: parent.verticalCenter // Centraliza verticalmente
            left: parent.left
            }
        
    onTextChanged: { 
    if (is_dolar === true) {
        result.text = backend.converte_Dolar_para_Real(input.text)
    } else {
        result.text = backend.converte_Real_para_Dolar(input.text)
    }
}

    }

    TextField {
        id: result
        width: 100
        height: 45
        readOnly: true
        text: ''
         // Define a largura do campo de texto
        placeholderText: "REAL"
         // Texto de dica
        font.pixelSize: 16
        anchors {
            // horizontalCenter: parent.horizontalCenter // Centraliza horizontalmente
            verticalCenter: parent.verticalCenter // Centraliza verticalmente
            right: parent.right
            }
    }    
   
    Image {
        id: imagem
        width: 40
        height: 40
        source:'imagens/seta.png' 
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit


    SequentialAnimation {
        id: clicou
        PropertyAnimation {
        target: imagem
        property: 'scale'
        to: 0.7
        duration: 30
    }
    PropertyAnimation {
        target: imagem
        property: 'scale'
        to: 1
        duration: 30
    }

    }
        PropertyAnimation{
        id: passou_mouse
        target: imagem
        property: 'scale'
        to: 1.1
    }       


        PropertyAnimation{
            id: animacao_notificacao
            target: notification
            property: 'width'
            to: 0
            duration: 300
        }
            PropertyAnimation{
            id: animacao_notificacao_entrada
            target: notification
            property: 'width'
            from: 0
            to: 150
            duration: 200
        }
     
      
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true //Garantindo a verificação de se o mouse está no MouseArea
    onClicked: {
        input.text = ''
        result.text = ''
    
        clicou.running = true
        if (is_dolar === true) {
            input.placeholderText = 'REAL'
            result.placeholderText = 'DOLAR'
            is_dolar = false
        } else {
            input.placeholderText = 'DOLAR'
            result.placeholderText = 'REAL'
            is_dolar = true
        }

    }
    onEntered: {
        passou_mouse.running = true
    }  
    onExited: {
        imagem.scale = 1
    }      

    }
               
    }


   Rectangle {
    id: notification
    width: 150
    height: 67
    color: "#80FFFFFF"
    visible: false
    radius: 10
    anchors {
        right: parent.right
        bottom: parent.bottom
        
    }
   
    
    Rectangle {
        id: fundo
        width: 150
        height: 20
        color: "#D3D3D3" 
        anchors.top: parent.top
        radius:10
    Rectangle{
        height: fundo.radius
        color: "#D3D3D3"
        anchors.bottom: fundo.bottom
        anchors.left: fundo.left
        anchors.right: fundo.right
        opacity: 1
    }
        Text {
            font.bold: true
            color: 'black'
            anchors.centerIn: parent
            text: backend.verifica()
        }


    }

        Text {
        text: backend.value_notification()
        font.bold: false
        color: 'black'
        anchors {
        top: fundo.top
        horizontalCenter: fundo.horizontalCenter
        topMargin: 33 }
    
        }

        MouseArea{
            id: area_notification
            hoverEnabled: true
            anchors.fill: parent

            onEntered: notification.opacity = 0.88
            onExited: notification.opacity = 1
        }

   Image {
        id: close
        width: 10
        height: 10
        source: 'imagens/fechar.png'
        anchors {
            left: parent.left
            top: parent.top
            leftMargin: 5
            topMargin: 5
        }

        MouseArea {
            hoverEnabled: true
            anchors.fill: parent
            onEntered: {
                close.scale = 1.2  
            }
            onExited: {
                close.scale = 1

            }
            onClicked: notification.visible = false
        }
    }        
  
}
        Timer {
        interval: 1000
        running: true
        onTriggered: {
            notification.visible = true
            animacao_notificacao_entrada.running = true  
        } 
        
        }

   Timer {
            interval: 7000// Tempo em milissegundos (5 segundos)
            running: true
            onTriggered: {
                animacao_notificacao.running = true
            }

    }

    }