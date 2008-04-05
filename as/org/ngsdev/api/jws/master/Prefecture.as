package org.ngsdev.api.jws.master {
	import org.ngsdev.api.jws.*;
	import org.ngsdev.api.jws.master.*;
	import flash.events.Event;
	public class Prefecture extends Area {
		function Prefecture(x:XML) {
			super(x);
			for each (var pref:XML in x.LargeArea) {
				//areas.push(new LargeArea(pref));
			}
		}
	}
}