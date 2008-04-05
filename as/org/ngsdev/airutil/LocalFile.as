package org.ngsdev.airutil {
	import org.ngsdev.airutil.*;
	import flash.filesystem.*;
	public class LocalFile {
		public static function write(fname:String="",data:String="") {
			var file:File = File.applicationStorageDirectory.resolvePath(fname);
			var stream:FileStream = FileStream("");
			stream.open(file, FileMode.WRITE);
			stream.writeMultiByte(data, File.systemCharset);
			stream.close();
		}
		public static function read(fname:String=""):String {
			var data:String = "";
			if(!fname) return data;
			var file:File = File.applicationStorageDirectory.resolvePath(fname);
			if(!file.exists) return "";
			var stream:FileStream = FileStream("");
			stream.open(file, FileMode.READ);
			data = stream.readMultiByte(stream.bytesAvailable, File.systemCharset);
			stream.close();
			return data;
		}
	}
}