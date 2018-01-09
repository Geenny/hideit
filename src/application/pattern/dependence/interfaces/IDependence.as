package application.pattern.dependence.interfaces 
{
	
	/**
	 * ...
	 * @author FKSV
	 */
	public interface IDependence {
		
		/**
		 * Зависимость готова
		 */
		function get ready():Boolean;
		function set ready(value:Boolean):void;
		
		/**
		 * Вернуть имя
		 */
		function get name():String;
		function set name(value:String):void;
		
		/**
		 * Список
		 */
		function get list():Vector.<IDependence>;
		
		/**
		 * Наличие зависимостей
		 */
		function get hasDependencies():Boolean;
		
		/**
		 * В списке зависимостей присутствует данная зависимость
		 * @param	dependence
		 */
		function getDependenceByName(name:String):IDependence;
		
		/**
		 * В списке зависимостей присутствует данная зависимость
		 * @param	dependence
		 */
		function hasDependence(dependence:IDependence):Boolean;
		
		/**
		 * Наличие неготовых зависимостей
		 */
		function get hasUnreadyDependence():Boolean;
		
		/**
		 * Вернуть первую не готовую зависимость
		 */
		function getFirstUnreadyDependence():IDependence;
		
		/**
		 * Инициировать подготовку зависимости
		 */
		function forceReadyCheck():void;
		
		/**
		 * Форсирование запущено и ожидает готовности дочерних компонентов
		 */
		function get forced():Boolean;
		function set forced(value:Boolean):void;
		
	}
	
}