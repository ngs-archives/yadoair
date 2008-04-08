package org.ngsdev.api.jws.master {
	public class SmallArea extends Area {
		function SmallArea(x:XML) {
			super(x);
			type = 3;
			default xml namespace = new Namespace("jws");
		}
	}
}