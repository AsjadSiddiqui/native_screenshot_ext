import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

/// Class to capture screenshots with native code working on background
class NativeScreenshot {
	/// Comunication property to talk to the native background code.
	static const MethodChannel _channel =
	const MethodChannel('native_screenshot_ext');

	/// Captures everything as is shown in user's device.
	///
	/// Returns [null] if an error ocurrs.
	/// Returns a [String] with the path of the screenshot.
	static Future<String?> takeScreenshot() async {
		final String? path = await _channel.invokeMethod('takeScreenshot');

		return path;
	} // takeScreenshot()

	/// Captures everything as is shown in user's device.
	///
	/// Returns a [List<int>] with the png data for the screenshot,
	/// or [null] if an error occurs.
	static Future<List<int>?> takeScreenshotImage(int quality) async {
		final List<int>? image = await _channel.invokeMethod('takeScreenshotImage', <String, dynamic>{"quality": quality});
		return image;
	}
  
	/// Captures everything as is shown in user's device and returns it as a Uint8List.
	///
	/// This method doesn't save the screenshot as a file or request storage permissions.
	/// It simply returns the raw image data that can be used directly in memory.
	///
	/// [quality] - The quality of the resulting image, from 0-100. Default is 100 (best quality).
	///
	/// Returns a [Uint8List] containing the PNG data for the screenshot,
	/// or [null] if an error occurs.
	static Future<Uint8List?> captureScreenshot({int quality = 100}) async {
		try {
			final List<int>? imageData = await _channel.invokeMethod('takeScreenshotImage', <String, dynamic>{"quality": quality});
			if (imageData != null) {
				return Uint8List.fromList(imageData);
			}
		} catch (e) {
			print('Error capturing screenshot: $e');
		}
		return null;
	}
} // NativeScreenshot
