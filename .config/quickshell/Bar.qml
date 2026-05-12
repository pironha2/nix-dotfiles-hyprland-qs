import Quickshell
import Quickshell.Io 
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
// import color.default 

Scope {
  id: root
  property real verMargin: 5
  property real horMargin: 10
  property int fontHeight: 14
  property string fontFamily: "GeistMono Nerd Font"
  property real batUsage: 200
  property real volSpeak: 200
  property string batStatus: boom
  property string muted: boom

  // Colours
  property color panelBg:   "transparent"
  property color pillBg:    "#222133"
  property color colTok:    "#999999"
  property color colIAc:    "#333333"
  property color colTxt:    "#595c7b"
  
  Timer {
    interval: 20000
    running: true
    repeat: true
    onTriggered: {
      batProc.running = true
      isChargin.running = true
    }
  }

  Timer {
    interval: 500
    running:  true
    repeat: true
    onTriggered: {
      volProc.running = true
    }
  }
  
  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
  } 


  Process {
    id: batProc
    running: true
    command: ["sh", "-c", "cat /sys/class/power_supply/BAT*/capacity" ]
    stdout: StdioCollector {
      onStreamFinished: root.batUsage = this.text
    }
  } 
  
  Process {
    id: isChargin
    running: true
    command: ["sh", "-c", "cat /sys/class/power_supply/BAT*/status"]
    stdout: StdioCollector {
      onStreamFinished: root.batStatus = this.text
    }
  }

  Process {
    id: volProc
    running: true
    command: ["sh", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@" ]
    stdout: SplitParser {
      onRead: data => {
        if (!data) return
        var p = data.trim().split(/\s+/)
        volSpeak = Math.round(p[1] * 1000) / 10
        if (!p[2]) muted = ""
        muted = p[2]
      }
    }
  }

  
  PanelWindow {
    // exclusionMode: ExclusionMode.Ignore
    anchors {
      top: true
      left: true
      right: true
    }
    color: root.panelBg
    implicitHeight: root.fontHeight + root.verMargin * 4 
    
    RowLayout {
      anchors.fill: parent
      anchors.margins: root.horMargin
      spacing: root.horMargin
      
      RowLayout {
        anchors.left: parent.left

        ClippingRectangle {
          color: root.pillBg
          implicitHeight: root.fontHeight + root.verMargin * 2
          implicitWidth: pill1.width + root.horMargin * 2
          radius: implicitHeight / 2
          x: root.horMargin
          y: root.verMargin

          RowLayout {
            id: pill1
            anchors.centerIn: parent
            anchors.margins: root.horMargin
            
            Repeater {
              model: 9
              anchors.fill: parent
              anchors.centerIn: parent

              Text {
                property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                text: index + 1
                color: isActive ? colTxt: (ws ? colTok : colIAc)
                font { pixelSize: root.fontHeight; bold: true; family: root.fontFamily; }

                MouseArea {
                  anchors.fill: parent
                  onClicked: Hyprland.dispatch("workspace " + (index + 1))
                }
              }
            }
          }
        }
      }

      RowLayout {
        anchors.margins: root.horMargin
        spacing: root.horMargin
        anchors.horizontalCenter: parent.horizontalCenter
        

        ClippingRectangle {
          color: root.pillBg
          implicitHeight: root.fontHeight + root.verMargin * 2
          implicitWidth: clock.width + root.horMargin * 2 
          radius: height / 2 
          
          Text {
            id: clock
            text: Qt.formatDateTime(new Date(), "ddd, MM dd - HH:mm")
            color: root.colTxt
            anchors.centerIn: parent
            font { pixelSize: root.fontHeight; bold: true; family: root.fontFamily; }
          }
        }
      }
      
      RowLayout {
        anchors.right: parent.right
        
        ClippingRectangle {
          color: root.pillBg
          implicitHeight: root.fontHeight + root.verMargin * 2
          implicitWidth: pill3.width + root.horMargin * 2 
          radius: height / 2 
          anchors.verticalCenter: parent.center

          Text {
            id: pill3
            text: {
              if (root.muted === "") return "󰕾 " + volSpeak + "%"
              else return "󰖁 " + volSpeak + "%"
            }
            anchors.centerIn: parent
            color: root.colTxt
            font { pixelSize: root.fontHeight; bold: true; family: root.fontFamily; }
          }
        }

        // ClippingRectangle {
        //   color: root.pillBg
        //   implicitHeight: root.fontHeight + root.verMargin * 2
        //   implicitWidth: pill4.width + root.horMargin * 2 
        //   radius: height / 2 
        //
        //   Text {
        //     id: pill4
        //     text: batStatus
        //     anchors.centerIn: parent
        //     color: root.colTxt
        //     font { pixelSize: root.fontHeight; bold: true; family: root.fontFamily; }
        //   }
        // }
 
        ClippingRectangle {
          color: root.pillBg
          implicitHeight: root.fontHeight + root.verMargin * 2
          implicitWidth: pill2.width + root.horMargin * 2 
          radius: height / 2 

          Text {
            id: pill2
            text: {
              if ( batStatus === "Charging\n" ) { return "󰂄 " + batUsage + "%" }
              else { 
                if ( batUsage > 95) return "󰁹 " + batUsage + "%"
                if ( batUsage > 85) return "󰂂 " + batUsage + "%"
                if ( batUsage > 75) return "󰂁 " + batUsage + "%"
                if ( batUsage > 65) return "󰂀 " + batUsage + "%"
                if ( batUsage > 55) return "󰁿 " + batUsage + "%"
                if ( batUsage > 45) return "󰁾 " + batUsage + "%"
                if ( batUsage > 35) return "󰁽 " + batUsage + "%"
                if ( batUsage > 25) return "󰁼 " + batUsage + "%"
                if ( batUsage > 15) return "󰁻 " + batUsage + "%"
                if ( batUsage > 05) return "󰁺 " + batUsage + "%"
                return "󰂃 " + batUsage + "%"
              }
            }
            anchors.centerIn: parent
            color: root.colTxt
            font { pixelSize: root.fontHeight; bold: true; family: root.fontFamily; }
          }
        }
      }
    }
  }
}
