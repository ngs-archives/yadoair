package org.ngsdev.api.jws.search {
	import org.ngsdev.api.jws.search.*;
	import flash.events.EventDispatcher;
	public class YadoResult extends EventDispatcher {
		public var id:String, name:String, postcode:String, type:String, address:String, namekana:String,
			detailurl:String, catchcopy:String, caption:String, pictureurl:String, picturecaption:String, onsenname:String,
			checkintime:String, checkouttime:String, last_update:Date, area:Object, creditcard:Object,
			numberofratings:Number,rating:Number,sampleratefrom:Number;
		[ArrayElementType("YadoResultPlan")]
		public var plans:Array;
		[ArrayElementType("Object")]
		public var access:Array;
		private var _lat:Number, _lng:Number;
		function YadoResult(x:XML) {
			default xml namespace = new Namespace("jws");
			if(x) {
				access = [];
				plans = [];
				var t:String, key:String, atrs:Object;
				for each (var n:XML in x.children()) {
					t = n.text();
					atrs = n.attributes();
					key = n.name().localName.replace(/Hotel/g,"").toLowerCase();
					switch(n.name().localName) {
					case "Area":
						area = {};
						for each(var a:XML in n.children()) {
							var lcn:String = a.name().localName;
							if(lcn) area[lcn] = a.text();
						}
						break;
					case "AccessInformation": access.push({name:n.@name, text:t}); break;
					case "LastUpdate":
						last_update = new Date(parseInt(n.@year), parseInt(n.@month)-1, parseInt(n.@day));
						break;
					case "CreditCard":
						creditcard = new Object();
						for each (var c:XML in atrs) creditcard[c.name().toString().replace(/@/i,"")] = c == "true";
						break;
					case "X": _lat = parseInt(t)/10000000; break;
					case "Y": _lng = parseInt(t)/10000000; break;
					case "Plan": plans.push(new YadoResultPlan(n)); break;
					case "NumberOfRatings":
					case "SampleRateFrom":
					case "Rating":
						this[key] = parseInt(t);
						break;
					default:
						this[key] = t;
						break;
					}
				}
			}
		}
		public function getPosition(dat:String=""):Array {
			var ret:Array = [_lat,_lng];
			if(dat != "tokyo") {
				ret[0] = _lng - _lat * 0.000046038 - _lng * 0.000083043 + 0.010040;
				ret[1] = _lat - _lat * 0.00010695 + _lng * 0.000017464 + 0.0046017; 
			}
			return ret;
		}
	}
}