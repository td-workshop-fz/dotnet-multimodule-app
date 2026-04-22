namespace shapes;

public class Shape
{
    public virtual string GetName() => "Generic Shape";
}

public class Circle : Shape
{
    public override string GetName() => "Circle";
}
