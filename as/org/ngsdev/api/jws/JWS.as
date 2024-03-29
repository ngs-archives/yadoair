﻿/* ===============================================
*
*  org.ngsdev.api.jws.JWS
*  Jalan WebService for ActionScript3.0
*  JWSreference : http://jws.jalan.net/
*  HostedBy     : http://code.google.com/p/yadoair/
*
*  (C)atsushi nagase http://ngsdev.org/
*  License : Mozilla Public License 1.1
*
=============================================== */
package org.ngsdev.api.jws {
	import org.ngsdev.api.jws.*;
	import org.ngsdev.api.jws.master.*;
	import org.ngsdev.api.jws.search.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	public class JWS extends EventDispatcher {
		public static var apikey = "";
		public static const GET_YADOS:String  = "onGetYados";
		public static const AREAS_INIT:String  = "onAreasInit";
		public static const ERROR:String  = "onAreasInit";
		public var areaMaster:AreaMaster;
		public var yadoSearch:YadoSearch;
		[ArrayElementType("String")]
		public static var errormsg:Array;
		public static var self:JWS;
		//
		public function JWS(a:String="") {
			apikey = a;
			self = this;
		}
		public function getAreas():void {
			if(areaMaster) {
				onAreasInit();
			} else {
				areaMaster = new AreaMaster();
				areaMaster.addEventListener(AreaMaster.INIT,onAreasInit);
			}
		}
		private function onAreasInit(e:Event=null):void {
			dispatchEvent(new Event(JWS.AREAS_INIT));
		}
		public function getYados(prm:YadoSearchParam,adv:Boolean=false):void {
			if(!yadoSearch) {
				yadoSearch = new YadoSearch();
				yadoSearch.addEventListener(YadoSearch.INIT,onGetYados);
			}
			yadoSearch.search(prm,adv);
		}
		private function onGetYados(e:Event=null) {
			dispatchEvent(new Event(JWS.GET_YADOS));
		}
		public static function error(x:XML) {
			default xml namespace = new Namespace("jws");
			errormsg = [];
			for each (var m:XML in x.Error.Message) {
				errormsg.push(m.text());
			}
			self.dispatchEvent(new Event(JWS.ERROR));
		}
	}
}