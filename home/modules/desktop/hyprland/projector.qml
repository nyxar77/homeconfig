// nyxar: projector panel for Hyprland's Lua config manager.
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtCore
import Quickshell
import Quickshell.Io

FloatingWindow {
	id: root

	property string homeDir: StandardPaths.writableLocation(StandardPaths.HomeLocation)
	property string statusText: "Ready"
	property string builtinOutput: ""
	property string externalOutput: ""
	property bool builtinDisabled: false
	property bool externalDisabled: false
	property var monitors: []
	property var scheme: ({})

	visible: true
	title: "Projector"
	width: 460
	height: 390
	minimumSize.width: 420
	minimumSize.height: 360
	maximumSize.width: 500
	maximumSize.height: 430
	color: "transparent"

	function token(name, fallback) {
		if (scheme && scheme.colours && scheme.colours[name] && scheme.colours[name].hex)
			return "#" + scheme.colours[name].hex;
		if (scheme && scheme[name] && scheme[name].hex)
			return "#" + scheme[name].hex;
		if (scheme && typeof scheme[name] === "string")
			return "#" + scheme[name].replace("#", "");
		return fallback;
	}

	readonly property color base: token("surface", "#101316")
	readonly property color surface: token("surfaceContainer", "#181c20")
	readonly property color surfaceHigh: token("surfaceContainerHigh", "#22272b")
	readonly property color primary: token("primary", "#f8b89f")
	readonly property color secondary: token("secondary", "#e7beaf")
	readonly property color tertiary: token("tertiary", "#ffe0a6")
	readonly property color primaryContainer: token("primaryContainer", "#5c2d1d")
	readonly property color secondaryContainer: token("secondaryContainer", "#54382f")
	readonly property color tertiaryContainer: token("tertiaryContainer", "#57431b")
	readonly property color onPrimary: token("onPrimary", "#28150e")
	readonly property color onSurface: token("onSurface", "#e6e1de")
	readonly property color muted: token("onSurfaceVariant", "#cfc5bf")
	readonly property color outline: token("outline", "#9b8f89")
	readonly property bool lightSurface: luminance(base) > 0.62
	readonly property color textStrong: lightSurface ? "#171412" : "#eee8e3"
	readonly property color textSoft: lightSurface ? "#5f5751" : "#cfc7c0"

	function luminance(value) {
		return (0.2126 * value.r) + (0.7152 * value.g) + (0.0722 * value.b);
	}

	FileView {
		id: schemeFile
		path: root.homeDir + "/.local/state/caelestia/scheme.json"
		preload: true
		watchChanges: true
		printErrors: false
		onLoaded: root.loadScheme()
		onTextChanged: root.loadScheme()
	}

	Timer {
		interval: 80
		running: true
		repeat: false
		onTriggered: {
			root.loadScheme();
			refreshProcess.exec(["hyprctl", "monitors", "all", "-j"]);
		}
	}

	Process {
		id: refreshProcess
		stdout: StdioCollector {
			id: monitorStdout
			onStreamFinished: root.loadMonitors(text)
		}
		stderr: StdioCollector {}
	}

	Process {
		id: commandProcess
		stdout: StdioCollector {}
		stderr: StdioCollector {
			id: commandStderr
			onStreamFinished: {
				if (text.trim().length > 0)
					root.statusText = text.trim();
			}
		}
		onExited: function(exitCode) {
			if (exitCode === 0) {
				refreshProcess.exec(["hyprctl", "monitors", "all", "-j"]);
			} else if (commandStderr.text.trim().length === 0) {
				root.statusText = "Hyprland command failed";
			}
		}
	}

	function loadScheme() {
		try {
			const raw = schemeFile.text();
			if (raw && raw.length > 0)
				scheme = JSON.parse(raw);
		} catch (error) {
			scheme = {};
		}
	}

	function loadMonitors(raw) {
		try {
			monitors = JSON.parse(raw || "[]");
		} catch (error) {
			monitors = [];
		}

		const available = monitors.filter(m => m && m.name);
		const active = available.filter(m => !m.disabled);
		const builtin = available.find(m => /^(eDP|LVDS)-/.test(m.name));
		const external = available.find(m => !/^(eDP|LVDS)-/.test(m.name));

		if (builtin)
			builtinOutput = builtin.name;
		if (external)
			externalOutput = external.name;

		const currentBuiltin = available.find(m => m.name === builtinOutput);
		const currentExternal = available.find(m => m.name === externalOutput);
		builtinDisabled = currentBuiltin ? currentBuiltin.disabled === true : false;
		externalDisabled = currentExternal ? currentExternal.disabled === true : false;

		if (available.length === 0) {
			statusText = "No outputs detected";
		} else if (active.length === 0) {
			statusText = "No active outputs";
		} else {
			statusText = "Active " + active.length + " / known " + available.length + " outputs";
		}
	}

	function outputLabel(name, disabled) {
		if (!name)
			return "missing";
		return disabled ? name + " (off)" : name;
	}

	function quote(value) {
		return String(value).replace(/\\/g, "\\\\").replace(/"/g, "\\\"");
	}

	function monitorLua(output, mode, position, scale, extra) {
		let parts = [
			'output = "' + quote(output) + '"',
			'mode = "' + quote(mode) + '"',
			'position = "' + quote(position) + '"',
			"scale = " + scale
		];

		if (extra)
			parts = parts.concat(extra);

		return "hl.monitor({ " + parts.join(", ") + " })";
	}

	function runLua(lines, label) {
		statusText = label;
		commandProcess.exec(["hyprctl", "eval", lines.join("\n")]);
	}

	function requireOutputs() {
		if (!builtinOutput || !externalOutput) {
			statusText = "Need built-in and external displays";
			return false;
		}
		return true;
	}

	function builtInOnly() {
		if (!builtinOutput)
			return statusText = "No built-in display found";
		const lines = [monitorLua(builtinOutput, "preferred", "0x0", 1)];
		if (externalOutput)
			lines.push('hl.monitor({ output = "' + quote(externalOutput) + '", disabled = true })');
		runLua(lines, "Using built-in display");
	}

	function externalOnly() {
		if (!externalOutput)
			return statusText = "No external display found";
		const lines = [monitorLua(externalOutput, "preferred", "0x0", 1)];
		if (builtinOutput)
			lines.push('hl.monitor({ output = "' + quote(builtinOutput) + '", disabled = true })');
		runLua(lines, "Using external display");
	}

	function duplicate() {
		if (!requireOutputs())
			return;
		runLua([
			monitorLua(builtinOutput, "1920x1080@60", "0x0", 1),
			monitorLua(externalOutput, "1920x1080@60", "0x0", 1, ['mirror = "' + quote(builtinOutput) + '"'])
		], "Duplicating displays");
	}

	function extendRight() {
		if (!requireOutputs())
			return;
		runLua([
			monitorLua(builtinOutput, "preferred", "0x0", 1),
			monitorLua(externalOutput, "preferred", "auto-right", 1)
		], "Extending right");
	}

	function extendLeft() {
		if (!requireOutputs())
			return;
		runLua([
			monitorLua(externalOutput, "preferred", "0x0", 1),
			monitorLua(builtinOutput, "preferred", "auto-right", 1)
		], "Extending left");
	}

	Rectangle {
		anchors.fill: parent
		radius: 20
		color: Qt.rgba(root.base.r, root.base.g, root.base.b, 0.96)
		border.color: Qt.rgba(root.outline.r, root.outline.g, root.outline.b, 0.22)
		border.width: 1

		Rectangle {
			anchors.fill: parent
			anchors.margins: 1
			radius: 19
			gradient: Gradient {
				GradientStop { position: 0; color: Qt.rgba(root.primary.r, root.primary.g, root.primary.b, 0.06) }
				GradientStop { position: 0.52; color: Qt.rgba(root.secondary.r, root.secondary.g, root.secondary.b, 0.035) }
				GradientStop { position: 1; color: Qt.rgba(root.tertiary.r, root.tertiary.g, root.tertiary.b, 0.055) }
			}
		}

		ColumnLayout {
			anchors.fill: parent
			anchors.margins: 16
			spacing: 10

			RowLayout {
				Layout.fillWidth: true
				spacing: 10

				ColumnLayout {
					Layout.fillWidth: true
					spacing: 2

					Text {
						text: "Projector"
						color: root.textStrong
						font.pixelSize: 19
						font.weight: Font.DemiBold
					}

					Text {
						text: root.builtinOutput && root.externalOutput ? root.builtinOutput + " + " + root.externalOutput : "Connect an HDMI or DP display"
						color: root.textSoft
						font.pixelSize: 11
						elide: Text.ElideRight
						Layout.fillWidth: true
					}
				}

				ToolButton {
					text: "↻"
					font.pixelSize: 17
					implicitWidth: 34
					implicitHeight: 34
					onClicked: refreshProcess.exec(["hyprctl", "monitors", "all", "-j"])

					background: Rectangle {
						radius: 10
						color: parent.hovered ? Qt.rgba(root.primary.r, root.primary.g, root.primary.b, 0.15) : Qt.rgba(root.surface.r, root.surface.g, root.surface.b, 0.62)
						border.color: Qt.rgba(root.outline.r, root.outline.g, root.outline.b, 0.16)
					}

					contentItem: Text {
						text: parent.text
						color: root.textStrong
						horizontalAlignment: Text.AlignHCenter
						verticalAlignment: Text.AlignVCenter
						font: parent.font
					}
				}
			}

			RowLayout {
				Layout.fillWidth: true
				spacing: 8

				DisplayChip {
					Layout.fillWidth: true
					title: "Built-in"
					value: root.outputLabel(root.builtinOutput, root.builtinDisabled)
					accent: root.primary
				}

				DisplayChip {
					Layout.fillWidth: true
					title: "External"
					value: root.outputLabel(root.externalOutput, root.externalDisabled)
					accent: root.tertiary
				}
			}

			GridLayout {
				Layout.fillWidth: true
				Layout.fillHeight: true
				columns: 3
				columnSpacing: 8
				rowSpacing: 8

				ModeButton {
					Layout.fillWidth: true
					Layout.preferredHeight: 96
					glyph: "▣"
					title: "Built-in only"
					subtitle: "Laptop panel stays active"
					accent: root.primary
					accentSoft: root.primaryContainer
					onClicked: root.builtInOnly()
				}

				ModeButton {
					Layout.fillWidth: true
					Layout.preferredHeight: 96
					glyph: "▰"
					title: "HDMI only"
					subtitle: "External display takes over"
					accent: root.tertiary
					accentSoft: root.tertiaryContainer
					onClicked: root.externalOnly()
				}

				ModeButton {
					Layout.fillWidth: true
					Layout.preferredHeight: 96
					glyph: "⧉"
					title: "Duplicate"
					subtitle: "Mirror built-in to external"
					accent: root.secondary
					accentSoft: root.secondaryContainer
					onClicked: root.duplicate()
				}

				ModeButton {
					Layout.fillWidth: true
					Layout.preferredHeight: 96
					glyph: "▣▰"
					title: "Extend right"
					subtitle: "External display on the right"
					accent: root.primary
					accentSoft: root.primaryContainer
					onClicked: root.extendRight()
				}

				ModeButton {
					Layout.fillWidth: true
					Layout.preferredHeight: 96
					glyph: "▰▣"
					title: "Extend left"
					subtitle: "External display on the left"
					accent: root.tertiary
					accentSoft: root.tertiaryContainer
					onClicked: root.extendLeft()
				}
			}

			Rectangle {
				Layout.fillWidth: true
				implicitHeight: 30
				radius: 10
				color: Qt.rgba(root.surfaceHigh.r, root.surfaceHigh.g, root.surfaceHigh.b, 0.48)
				border.color: Qt.rgba(root.outline.r, root.outline.g, root.outline.b, 0.12)

				Text {
					anchors.fill: parent
					anchors.leftMargin: 10
					anchors.rightMargin: 10
					text: root.statusText
					color: root.textSoft
					font.pixelSize: 11
					verticalAlignment: Text.AlignVCenter
					elide: Text.ElideRight
				}
			}
		}
	}

	component DisplayChip: Rectangle {
		required property string title
		required property string value
		required property color accent

		implicitHeight: 44
		radius: 12
		color: Qt.rgba(root.surfaceHigh.r, root.surfaceHigh.g, root.surfaceHigh.b, 0.44)
		border.color: Qt.rgba(accent.r, accent.g, accent.b, 0.26)
		border.width: 1

		RowLayout {
			anchors.fill: parent
			anchors.margins: 9
			spacing: 8

			Rectangle {
				Layout.preferredWidth: 8
				Layout.fillHeight: true
				radius: 4
				color: Qt.rgba(accent.r, accent.g, accent.b, 0.85)
			}

			ColumnLayout {
				Layout.fillWidth: true
				spacing: 2

				Text {
					text: title
					color: root.textSoft
					font.pixelSize: 10
					font.weight: Font.Medium
				}

				Text {
					Layout.fillWidth: true
					text: value
					color: root.textStrong
					font.pixelSize: 12
					font.weight: Font.DemiBold
					elide: Text.ElideRight
				}
			}
		}
	}

	component ModeButton: Button {
		required property string glyph
		required property string title
		required property string subtitle
		required property color accent
		required property color accentSoft

		implicitHeight: 96
		padding: 0

		background: Rectangle {
			radius: 14
			color: parent.down
				? Qt.rgba(accentSoft.r, accentSoft.g, accentSoft.b, 0.38)
				: parent.hovered
					? Qt.rgba(accentSoft.r, accentSoft.g, accentSoft.b, 0.28)
					: Qt.rgba(root.surface.r, root.surface.g, root.surface.b, 0.64)
			border.color: parent.hovered ? Qt.rgba(accent.r, accent.g, accent.b, 0.55) : Qt.rgba(root.outline.r, root.outline.g, root.outline.b, 0.16)
			border.width: 1
		}

		contentItem: ColumnLayout {
			anchors.fill: parent
			anchors.margins: 8
			spacing: 3

			Rectangle {
				Layout.fillWidth: true
				Layout.fillHeight: true
				Layout.minimumHeight: 44
				radius: 12
				color: Qt.rgba(accentSoft.r, accentSoft.g, accentSoft.b, 0.22)
				border.color: Qt.rgba(accent.r, accent.g, accent.b, 0.22)

				Text {
					anchors.centerIn: parent
					text: glyph
					color: accent
					font.pixelSize: glyph.length > 1 ? 34 : 40
					font.weight: Font.Bold
				}
			}

			ColumnLayout {
				Layout.fillWidth: true
				spacing: 1

				Text {
					Layout.fillWidth: true
					text: title
					color: root.textStrong
					font.pixelSize: 12
					font.weight: Font.DemiBold
					horizontalAlignment: Text.AlignHCenter
					elide: Text.ElideRight
				}

				Text {
					Layout.fillWidth: true
					text: subtitle
					color: root.textSoft
					font.pixelSize: 9
					horizontalAlignment: Text.AlignHCenter
					elide: Text.ElideRight
					maximumLineCount: 1
				}
			}
		}
	}
}
