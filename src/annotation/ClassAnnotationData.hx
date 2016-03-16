package annotation;

/**
 * @author Francis Bourre
 */
typedef ClassAnnotationData =
{
	name 							: String,
	superClassName 					: String,
	constructorAnnotationData		: MethodAnnotationData,
	properties 						: Array<PropertyAnnotationData>,
	methods							: Array<MethodAnnotationData>
}