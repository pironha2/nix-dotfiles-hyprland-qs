import Quickshell
import Quickshell.Io 
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes

PanelWindow {
  id: root
  property int size: 25
  property color bg: "#000000"

  anchors {
    top:    true
    left:   true
    right:  true
    bottom: true
  }
  color: "transparent"
  focusable: false
  aboveWindows: false
  exclusionMode: ExclusionMode.Ignore
  
  Shape {
    antialiasing: true
    anchors { left: parent.left; top: parent.top }
    implicitHeight: root.size
    implicitWidth: root.size
    ShapePath {
      fillColor: root.bg
      strokeWidth: 0
      startX: 0; startY: 0
      PathLine { x: 0;         y: 0         }
      PathLine { x: 0;         y: root.size }
      PathCubic {
        x: size;              y: 0
        control1X: 0;         control1Y: size / 2
        control2X: size / 2;  control2Y: 0
      }
      // PathLine { x: root.size; y: 0         }
    }
  }
  Shape {
    antialiasing: true
    anchors { left: parent.left; bottom: parent.bottom }
    implicitHeight: root.size
    implicitWidth: root.size
    ShapePath {
      fillColor: root.bg
      strokeWidth: 0
      startX: 0; startY: size
      PathLine { x: 0;      y: size        }
      PathLine { x: size;   y: size        }
      PathCubic {
        x: 0;                 y: 0
        control1X: size / 2;  control1Y: size 
        control2X: 0;         control2Y: size / 2
      }        
      PathLine { x: 0; y: 0 } 
    }
  }
  Shape {
    antialiasing: true
    anchors { right: parent.right; top: parent.top }
    implicitHeight: root.size
    implicitWidth: root.size
    ShapePath {
      fillColor: root.bg
      strokeWidth: 0
      startX: size; startY: 0
      PathLine { x: size;         y: 0      }
      PathLine { x: 0;            y: 0      }
      PathCubic { 
        x: size;              y: size
        control1X: size / 2;  control1Y: 0
        control2X: size;      control2Y: size / 2 
      }
      // PathLine { x: root.size; y: root.size }
    }
  }
  Shape {
    antialiasing: true
    anchors { right: parent.right; bottom: parent.bottom }
    implicitHeight: root.size
    implicitWidth: root.size
    ShapePath {
      fillColor: root.bg
      strokeWidth: 0
      startX: size; startY: size
      PathLine { x: size;     y: size }
      PathLine { x: 0;        y: size }
      PathCubic { 
        x: size;      y: 0 
        control1X: size / 2;  control1Y: size
        control2X: size;      control2Y: size / 2 
      }
    }
  }

  // Rectangle {
  //   anchors { right: parent.right; top: parent.top; }
  //   color: root.bg
  //   implicitWidth:  height
  //   implicitHeight: root.size
  // }
  // Rectangle {
  //   anchors { left: parent.left; bottom: parent.bottom; }
  //   color: root.bg
  //   implicitWidth:  height
  //   implicitHeight: root.size
  // }
  // Rectangle {
  //   anchors { right: parent.right; bottom: parent.bottom; }
  //   color: root.bg
  //   implicitWidth:  height
  //   implicitHeight: root.size
  // }
}
