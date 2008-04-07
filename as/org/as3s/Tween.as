/**
 * org.as3s.Tween
 * 
 * Tween Class for ActionScript3.0
 * 
 * Download: http://as3s.org/tween/tween.zip
 *
 * Copyright (c) 2007 Hisato Ogata
 * Licensed under the MIT License
 * http://www.opensource.org/licenses/mit-license.php
 * 
 * @langversion ActionScript 3.0
 * @playerversion Flash 9
 * 
 * @version 1.6
 * @author Hisato Ogata
 * @see http://as3s.org/tween/
 * 
 * @example usage:
 * <listing version="3.0">
 * 
 * 	// Frame-Based Tweening
 * 	var tween:Tween = new Tween(mc, {x:300, y:200}, fl.motion.easing.Quadratic.easeInOut, 24);
 *  tween.addEventListener(Tween.UPDATE, onTweenUpdate);
 * 	tween.addEventListener(Tween.COMPLETE, onTweenComplete);
 * 	tween.start();
 * 
 * 	// Time-Based Tweening
 * 	var tween:Tween = new Tween(mc, {x:300, y:200}, fl.motion.easing.Quadratic.easeInOut, 1, null, true);
 * 
 * 	// Uniform Motion
 *  var tween:Tween = new Tween(mc, {x:100}, Tween.uniform, 0, [5]);
 *  
 *  // Proportional Easing
 * 	var tween:Tween = new Tween(mc, {x:100}, Tween.easing);
 *  var tween:Tween = new Tween(mc, {x:100}, Tween.easing, 0, [0.2]);
 *  
 *  // Delay
 *  var tween:Tween = new Tween(mc, null, null, 24);
 * 
 *  // Multi Step Tweening
 *  var tween:Tween = new Tween(mc, [{x:300}, fl.motion.easing.Quadratic.easeInOut, 24], 
 *                                  [null, null, 24],
 *                                  [{y:200}, Tween.easing]);
 * 
 * </listing>
 */
  
package org.as3s {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;
	import flash.utils.getQualifiedClassName;
	
	public class Tween extends EventDispatcher {
		
		public static const START:String  = "start";
		public static const UPDATE:String  = "update";
		public static const PAUSE:String  = "pause";
		public static const COMPLETE:String  = "complete";
		
		private static var frame:Sprite = new Sprite();
		private static var tweens:Array = new Array();
		private static var time:Number;
		
		private static function updateTween(event:Event=null):void {
			Tween.time = getTimer();
			for each (var t:Tween in Tween.tweens) {
				t.update();
			}
		}
		
		private static function addTween(tween:Tween):void {
			
			for each (var t:Tween in Tween.tweens) {
				if (t==tween) return;
			}
			if (Tween.tweens.length==0) {
				Tween.time = getTimer();
				Tween.frame.addEventListener(Event.ENTER_FRAME, Tween.updateTween);
			}
			Tween.tweens.push(tween);
			
		}
		
		private static function removeTween(tween:Tween):void {
			
			var i:int = Tween.tweens.length;
			while (i--) {
				if (Tween.tweens[i]==tween) {
					Tween.tweens.splice(i,1);
					return;
				}
			}
			if (Tween.tweens.length==0) {
				Tween.frame.removeEventListener(Event.ENTER_FRAME, Tween.updateTween);
			}
			
		}
		
		private var params:Object;
		private var paramsLength:int;
		private var initArgsList:Array = new Array();
		private var argsList:Array = new Array();
		private var func:Function;
		private var duration:Number = Number.POSITIVE_INFINITY;
		private var args:Array = new Array();
		private var useSeconds:Boolean = false;
		private var initParams:Object;
		
		private var initTime:Number;
		private var currentTime:Number;
		
		private var update:Function;
		private var updateEvent:Event;
		
		/**
		 * The flag to check the completion of the tween
		 * 
		 */
		private var _complete:int = 0;
		public function get complete():Boolean {
			return _complete >= paramsLength;
		}
		public function set complete(value:Boolean):void {
			if (value) {
				_complete++;
				if (complete) duration = 0;
			} else {
				_complete = 0;
			}
		}
		
		/**
		 * The Target Object that should be tweened (read only)
		 * 
		 */
		private var _target:Object;
		public function get target():Object {
			return _target;
		}
		
		/**
		 * The flag to pause tweening
		 * 
		 * @param value Set TRUE to pause tweening and set FALSE to resume tweening
		 * 
		 */
		private var _pause:Boolean = false;
		public function get pause():Boolean {
			return _pause;
		}
		public function set pause(value:Boolean):void {
			if (_pause != value) {
				_pause = value;
				if (currentTime < duration) {
					if (_pause) {
						Tween.removeTween(this);
					} else {
						if (useSeconds) initTime = Tween.time - currentTime;
						Tween.addTween(this);
					}
					dispatchEvent(new Event(Tween.PAUSE));
				}
			}
		}
		
		/**
		 * Constructor for Tween class
		 * 
		 * for Single Step Tween
		 * @param target Object that should be tweened
		 * @param params Object containing the specified parameters
		 * @param func A reference to a function with a (t, b, c, d) signature like the methods in the fl.motion.easing classes
		 * @param duration A value of the duration of the effect
		 * @param args An array of values to be passed to the easing function 
		 * @param useSeconds A flag specifying whether to use seconds instead of frames
		 * 
		 * for Multi Step Tween
		 * @param target Object that should be tweened
		 * @param argsList An array of args to be passed to 'setTween' function
		 * 
		 */	
		public function Tween(target:Object, ...args) {
			
			_target = target;
			if (args.length>0) setTween.apply(this, args);
			
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			if (type == Tween.UPDATE) updateEvent = new Event(Tween.UPDATE);
			
		}
		
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			
			super.addEventListener(type, listener, useCapture);
			if (type == Tween.UPDATE) updateEvent = null;
			
		}
		
		/**
		 * set tween args
		 * 
		 * @param params Object containing the specified parameters
		 * @param func A reference to a function with a (t, b, c, d) signature like the methods in the fl.motion.easing classes
		 * @param duration A value of the duration of the effect
		 * @param args An array of values to be passed to the easing function 
		 * @param useSeconds A flag specifying whether to use seconds instead of frames
		 * 
		 */
		private function setTweenArgs(params:Object, func:Function = null, duration:Number = Number.POSITIVE_INFINITY, args:Array = null, useSeconds:Boolean = false):void {
			
			this.params = new Object();
			paramsLength = 0;
			for (var key:String in params) {
				this.params[key] = params[key];
				paramsLength++;
			}
			this.func = func;
			this.duration = duration>0 ? (useSeconds ? duration*1000 : duration) : Number.POSITIVE_INFINITY;
			this.args = args != null ? args.concat() : null;
			this.useSeconds = useSeconds;
			this.initParams = new Object();
			
			if (useSeconds) {
				update = args == null ? updateSeconds : updateSecondsWithArgs;
			} else {
				update = args == null ? updateFrames : updateFramesWithArgs;
			}
			
		}
		
		/**
		 * set tween
		 * 
		 * for Single Step Tween
		 * @param params Object containing the specified parameters
		 * @param func A reference to a function with a (t, b, c, d) signature like the methods in the fl.motion.easing classes
		 * @param duration A value of the duration of the effect
		 * @param args An array of values to be passed to the easing function 
		 * @param useSeconds A flag specifying whether to use seconds instead of frames
		 * 
		 * for Multi Step Tween
		 * @param argsList An array of args to be passed to 'setTween' function
		 * 
		 */	
		public function setTween(...args):void {
			
			if (getQualifiedClassName(args[0])!="Array") args = new Array(args);
			initArgsList = args;
			reset();
			
		}
		
		/**
		 * Reset tweening
		 * 
		 */	
		public function reset():void {
			
			removeTween(this);
			argsList = initArgsList.concat();
			setTweenArgs.apply(this, argsList.shift());
			
		}
		
		/**
		 * Start tweening
		 * 
		 */		
		public function start():void {
			
			for (var key:String in params) {
				initParams[key] = target[key];
				params[key] -= initParams[key];
			}
			complete = false;
			pause = false;
			Tween.addTween(this);
			initTime = Tween.time;
			currentTime = 0;
			dispatchEvent(new Event(Tween.START));
			
		}
		
		/**
		 * Update the params once every frame
		 * 
		 */
		private function updateFrames():void {
			for (var key:String in initParams) {
				target[key] = func(currentTime, initParams[key], params[key], duration);
			}
			if (updateEvent) dispatchEvent(updateEvent);
			if (currentTime >= duration) setComplete();
			currentTime++;
		}
		private function updateFramesWithArgs():void {
			for (var key:String in initParams) {
				target[key] = func.apply(this, [currentTime, initParams[key], params[key], duration].concat(args));
			}
			if (updateEvent) dispatchEvent(updateEvent);
			if (currentTime >= duration) setComplete();
			currentTime++;
		}
		private function updateSeconds():void {
			for (var key:String in initParams) {
				target[key] = func(currentTime, initParams[key], params[key], duration);
			}
			if (updateEvent) dispatchEvent(updateEvent);
			if (currentTime >= duration) setComplete();
			currentTime = Tween.time - initTime;
		}
		private function updateSecondsWithArgs():void {
			for (var key:String in initParams) {
				target[key] = func.apply(this, [currentTime, initParams[key], params[key], duration].concat(args));
			}
			if (updateEvent) dispatchEvent(updateEvent);
			if (currentTime >= duration) setComplete();
			currentTime = Tween.time - initTime;
		}
		
		private function setComplete():void {
			for (var key:String in params) {
				target[key] = params[key] + initParams[key];
			}
			if (argsList.length>0) {
				setTweenArgs.apply(this, argsList.shift());
				start();
			} else {
				dispatchEvent(new Event(Tween.COMPLETE));
				Tween.removeTween(this);
			}
		}
		
		/**
		 * Uniform Motion Function (for Frame-Based only)
		 * 
	     * @param t Specifies the current time, between 0 and duration inclusive.
		 * @param b Specifies the initial value of the animation property.
		 * @param c Specifies the total change in the animation property.
		 * @param d Specifies the duration of the motion.
		 * 
		 * @param v Specifies the velocity of the motion.
		 * 
		 */	
		public static var uniform:Function = function(t:Number, b:Number, c:Number, d:Number, v:Number = 1):Number {
			if (v*c<0) v = -v;
			if ((v*t<0 ? -v*t : v*t) > (c<0 ? -c : c)) {
				this.complete = true;
				return b + c;
			} else {
				this.complete = false;
				return b + v*t
			}
		};
		
		/**
		 * Basic Fractional Easing Function (for Frame-Based only)
		 * 
	     * @param t Specifies the current time, between 0 and duration inclusive.
		 * @param b Specifies the initial value of the animation property.
		 * @param c Specifies the total change in the animation property.
		 * @param d Specifies the duration of the motion.
		 * 
		 * @param base Specifies the value of the fraction.
		 * @param threshold Specifies the value of the threshold of the convergence.
		 * 
		 */	
		public static var easing:Function = function(t:Number, b:Number, c:Number, d:Number, base:Number = 0.5, threshold:Number = 0.1):Number {
			var r:Number = b;
			while (t--) {
				r += (b+c-r)*base;
			}
			if ((b+c-r<0 ? -(b+c-r) : b+c-r) < threshold) {
				this.complete = true;
				return b + c;
			} else {
				this.complete = false;
				return r;
			}
			
		};
		
	}
}