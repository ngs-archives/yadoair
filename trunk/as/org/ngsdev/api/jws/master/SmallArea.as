package org.ngsdev.api.jws.master {
	import org.ngsdev.api.jws.*;
	import org.ngsdev.api.jws.master.*;
	import flash.events.Event;
	public class SmallArea extends Area {
		function SmallArea(x:XML) {
			super(x);
			type = 3;
			default xml namespace = new Namespace("jws");
		}
	}
}