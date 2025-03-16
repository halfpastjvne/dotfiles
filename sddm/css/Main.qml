/***************************************************************************
* Copyright (c) 2013 Reza Fatahilah Shah <rshah0385@kireihana.com>
* Copyright (c) 2013 Abdurrahman AVCI <abdurrahmanavci@gmail.com>
*
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without restriction,
* including without limitation the rights to use, copy, modify, merge,
* publish, distribute, sublicense, and/or sell copies of the Software,
* and to permit persons to whom the Software is furnished to do so,
* subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included
* in all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
* OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
* OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
* ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
* OR OTHER DEALINGS IN THE SOFTWARE.
*
***************************************************************************/

import QtQuick 2.0
import SddmComponents 2.0

Rectangle {
	width: 640
	height: 480

    	LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    	LayoutMirroring.childrenInherit: true
	property int sessionIndex: session.index
    	TextConstants { id: textConstants }

    	Connections {
		target: sddm
		onLoginSucceeded: {}
        	onInformationMessage: {}
        	onLoginFailed: { pw_entry.text = ""; }
    	}

    	Background {
        	anchors.fill: parent
        	source: config.background
        	fillMode: Image.PreserveAspectCrop
        	onStatusChanged: {
            		if (status == Image.Error && source != config.defaultBackground) {
                		source = config.defaultBackground
            		}
        	}
    	}

    	Rectangle {
        	anchors.fill: parent
        	color: "transparent"

		Rectangle {
			id: log
            		width: 832; height: 524
			color: "#777777"
			radius: 10
			opacity: .8
			
			x: (log.parent.width - width)/2
			y: (log.parent.height - height)/2

			Item {
				anchors.margins: 10
				anchors.fill: parent

				Text {
					height: 50
					anchors.top: parent.top
					anchors.left: parent.left;
					anchors.topMargin: 10
					anchors.leftMargin: 10
					color: "#d8dee9"
					font.family: "Counter-Strike"
					text: sddm.hostName || "Login"

					font.pixelSize: 36
				}
				MouseArea {
					anchors.bottom: grb.top
					anchors.left: parent.left
					anchors.right: parent.right
					height: 70
					drag.target: log
					drag.axis: Drag.XAndYAxis
					drag.minimumX: 0
					drag.minimumY: 0
					drag.maximumX: log.parent.width-log.width
					drag.maximumY: log.parent.height-log.height
				}
				Rectangle {
					id: grb
					color: "#575757"
					border.width: 2
					border.color: "#b5b5b4"
					anchors.fill: parent
					anchors.topMargin: 60
					anchors.bottomMargin: 80
				}
				Rectangle {
					color: "#aa797979"
					opacity: 1
					height: 60
					border.width: 2
					border.color: "#b5b5b4"
					anchors.top: grb.bottom
					anchors.topMargin: -2
					anchors.bottom: parent.bottom
					anchors.right: parent.right
					anchors.left: parent.left
					anchors.bottomMargin: 20
					Row {
						anchors.right: parent.right
						anchors.rightMargin: 15
						anchors.verticalCenter: parent.verticalCenter
						spacing: 5
						Text {
							font.family: "CaskaydiaCove Nerd Font"
							font.pixelSize: 24
							text: "Username"
							color: "#d8dee9"
						}
						TextBox {
							id: user_entry

							width: 250; height: 33
							color: "#7f7f7f"
							font.family: "CaskaydiaCove Nerd Font"
							text: userModel.lastUser
							textColor: "#d8dee9"
							font.pixelSize: 24
						}
						Text {
							font.family: "CaskaydiaCove Nerd Font"
							font.pixelSize: 24
							color: "#d8dee9"
							text: "Password"
						}
						PasswordBox {
							id: pw_entry
							width: 250; height: 33
							color: "#7f7f7f"
							font.pixelSize: 24
							textColor: "#d8dee9"
							font.family: "CaskaydiaCove Nerd Font"
							borderColor: "#b5b5b4"
							hoverColor: "#b5b5b4"
							focusColor: "#b5b5b4"

							Keys.onPressed: {
								if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
									sddm.login(user_entry.text, pw_entry.text, sessionIndex)
									event.accepted = true
								}
							}
						}
					}
				}
				Text {
					text: " "
					font.pixelSize: 24
					color: "#d8dee9"
					anchors.right: parent.right; anchors.top: parent.top
					anchors.topMargin: -10
				}
			}
        		Component.onCompleted: {
        			if (user_entry.text == "")
            				user_entry.focus = true
				else
            				pw_entry.focus = true
    			}
		}
	}
}
