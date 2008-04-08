package org.ngsdev.api.jws.master {
	import flash.events.EventDispatcher;
	public class Area extends EventDispatcher {
		public var code:String;
		public var name:String;
		[ArrayElementType("Area")]
		public var areas:Array;
		public var type:int;
		function Area(x:XML) {
			code = x.@cd;
			name = x.@name;
			areas = [];
		}
	}
}