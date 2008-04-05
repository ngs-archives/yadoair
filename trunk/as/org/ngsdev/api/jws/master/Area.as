package org.ngsdev.api.jws.master {
	import org.ngsdev.api.jws.*;
	import org.ngsdev.api.jws.master.*;
	import flash.events.Event;
	public class Area {
		public var code:String;
		public var name:String;
		public var areas:Array;
		function Area(x:XML) {
			code = x.@cd;
			name = x.@name;
			areas = [];
			trace(name,code);
		}
	}
}