package org.ngsdev.api.jws.master {
	import org.ngsdev.api.jws.*;
	import org.ngsdev.api.jws.master.*;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	public class AreaMaster {
		private var _jws:JWS;
		public var _init:Boolean = false;
		private var apiurl:String = "http://jws.jalan.net/APICommon/AreaSearch/V1/";
		private var _urlloader:URLLoader = new URLLoader();
		var regions:Array;
		public function AreaMaster(jws:JWS) {
			_jws = jws;
			_urlloader.addEventListener(Event.COMPLETE, onLoadXML);
			_urlloader.load(new URLRequest(apiurl+"?key="+jws.apikey));
		}
		private function onLoadXML(event:Event):void {
			var xml:XML = new XML(_urlloader.data);
			xml.ignoreWhitespace = true;
			default xml namespace = new Namespace("jws");
			regions = [];
			for each (var a:XML in xml.Area.Region) {
				regions.push(new Region(a));
			}
		}
		
	}
}