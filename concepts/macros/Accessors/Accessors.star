module Accessors {
	macro [
		`property` name (AST.Name) type (AST.TypeAnno)
		
		attrs (AST.AttributeList[Static, Noinherit, Inline, Hidden])
		
		{
			getter {
				`getter` body (AST.Block)
			}
			
			setter {
				`setter` body (AST.Block)
			}
		} is unordered
	] is pattern is statement {
		on [@name]: @type @attrs is getter @(getter.body)
		on [@(name[AST.Label]) @type] @attrs is setter @(setter.body)
	}
}
