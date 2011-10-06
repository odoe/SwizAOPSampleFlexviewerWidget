package widgets.swizaopsamples.model.vo
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	[Bindable]
	public class MapServiceItem extends EventDispatcher
	{
		public var description:String;
		public var name:String;
		public var serverType:String;
		public var type:int;
		public var url:String;
	}
}