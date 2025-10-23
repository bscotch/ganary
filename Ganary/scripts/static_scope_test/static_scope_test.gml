function Foo()
{
   static blah = 10;
}

function Bar() constructor
{
   var scope_1 = instanceof(self);
   Foo();
   var scope_2 = instanceof(self);
   grc_expect_eq(scope_1, scope_2, "scopes should match");
}

function Hello() constructor
{
	static variable = 0;
    
	static add = function() {
		Hello.variable++;
	}
}