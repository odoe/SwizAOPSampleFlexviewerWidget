package widgets.swizaopsamples.controller
{
	import com.esri.ags.utils.JSON;
	
	import mx.collections.ArrayList;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.utils.services.ServiceHelper;
	
	import widgets.swizaopsamples.model.AppModel;
	import widgets.swizaopsamples.model.vo.MapServiceItem;
	import widgets.swizaopsamples.service.MapDetailsService;

	public class MapDetailsController
	{
		protected static const DYNAMIC:int = 0;
		protected static const TILED:int = 1;
		
		[Inject]
		public var detailsService:MapDetailsService;
		
		[Inject]
		public var model:AppModel;
		
		[Inject]
		public var serviceHelper:ServiceHelper;
		
		public function MapDetailsController() { }
		
		[EventHandler( event="MapDetailsEvent.LOAD_SERVICES_REQUEST", properties="url" )]
		[PreAuthorize( requires="EDITOR" )]
		public function loadServices(url:String):void
		{
			serviceHelper.executeServiceCall( detailsService.loadServices( url ), handleLoadedServiceResults, null, [ url ] );
		}
		
		private function findServiceDetails( item:MapServiceItem ):void
		{
			serviceHelper.executeServiceCall( detailsService.findServiceDetails( item ), handleServiceDetailsResult, null, [ item ] );
		}
		
		private function handleLoadedServiceResults( event: ResultEvent, url:String ):void
		{
			var results:Object = JSON.decode( event.result.toString() );
			var list:Array = [];
			
			for each ( var o:Object in results.services ) {
				if ( o.type == "MapServer" ) {
					var item:MapServiceItem = new MapServiceItem();
					item.name = o.name;
					item.url = url + "/" + item.name + "/MapServer";
					list.push( item );
					findServiceDetails( item );
				}
			}
			
			list.sortOn( "name" );
			
			model.dataList = new ArrayList( list );
		}
		
		private function handleServiceDetailsResult( event:ResultEvent, item:MapServiceItem ):void
		{
			var details:Object = JSON.decode( event.result.toString() );
			item.description = details["serviceDescription"];
			if (!details["singleFusedMapCache"])
				item.type = DYNAMIC;
			else
				item.type = TILED;
		}
	}
}