package org.ngsdev.api.jws.master {
	import org.ngsdev.api.jws.*;
	import org.ngsdev.api.jws.master.*;
	import flash.events.Event;
	public class Area {
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