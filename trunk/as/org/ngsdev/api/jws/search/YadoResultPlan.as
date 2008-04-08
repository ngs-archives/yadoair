package org.ngsdev.api.jws.search {
	import flash.events.EventDispatcher;
	public class YadoResultPlan extends EventDispatcher {
		public var name:String, type:String, roomname:String, roomtype:String,
			checkin:String, checkout:String, meal:String, sampleratefrom:Number;
		[ArrayElementType("Object")]
		public var pictures:Array;
		function YadoResultPlan(x:XML) {
			default xml namespace = new Namespace("jws");
			if(x) {
				pictures = [];
				var t:String, key:String, atrs:Object;
				for each (var n:XML in x.children()) {
					t = n.text();
					atrs = n.attributes();
					key = n.name().localName.replace(/Plan/g,"").toLowerCase();
					switch(n.name().localName) {
					case "PlanPictureURL":
						pictures.push({ url:t });
						break;
					case "PlanPictureCaption":
						pictures[pictures.length-1].caption = t;
						break;
					case "SampleRateFrom": this[key] = parseInt(t); break;
					default: this[key] = t; break;
					}
				}
			}
		}
	}
}