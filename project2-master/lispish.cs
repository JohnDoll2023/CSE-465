// John Doll Project 2

using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;

public class LispishParser
{
	public enum Symbols
	{ 
		Program,
		SExpr,
		List,
		Seq,
		Atom,
		INT,
		REAL,
		STRING,
		ID,
		LITERAL,
		INVALID = -1 
	}
	
	const string Literal		= @"[\\(\\)]";
	const string Real			= @"(?>\+|-)?[0-9]*\.[0-9]+";
	const string Int			= @"(?>\+|-)?[0-9]+"; 
	const string String			= @"""(?>\\""|.)*""";
	const string ID				= @"[^\s""\(\)]+";
	const string Invalid		= @"[^\s]";

    public class Node
    { 
		public Symbols Symbol { get; set; }
		 	
		public string Text { get;set; }
			
		public Node[] Children { get; set;}

		public Node(Symbols symbol, params Node[] children)
		{
			this.Symbol = symbol;
			this.Text = "";
			this.Children = children; 
		}
 
		public Node(Symbols symbol, string text)
		{
			this.Symbol = symbol;
			this.Text = text;
			this.Children = new Node[0];
		}

        public void Print(string prefix = "")
        {
			string finish = "";
			if (this.Text != "")
			{
				finish = $" {this.Text}";
			} 
			Console.WriteLine($"{prefix + this.Symbol, -40}{finish}");
			prefix += "  ";
			 
			foreach (Node child in this.Children)
			{
				child.Print(prefix);
			}
        } 
    }
    static public List<Node> Tokenize(String src)
    {
       	List<Node> parsed = new List<Node>(); 
		Regex regexPattern = new Regex($"\\s*" + $"(?<{Symbols.LITERAL}>{Literal})" + $"|(?<{Symbols.REAL}>{Real})" + $"|(?<{Symbols.INT}>{Int})" + $"|(?<{Symbols.STRING}>{String})" + $"|(?<{Symbols.ID}>{ID})" + $"|(?<{Symbols.INVALID}>{Invalid})"); 

		foreach (Match match in regexPattern.Matches(src))
		{
			for (int i = 1; i < match.Groups.Count; i++)
			{
				if (match.Groups[i].Success)
				{
					Symbols symbol;
					if (!Enum.TryParse<Symbols>(match.Groups[i].Name, out symbol))
					{
						throw new Exception("Parsing issue");
					} 
					if (symbol == Symbols.INVALID) 
					{
						throw new Exception("Invalid token");
					}
					 
					parsed.Add(new Node(symbol, match.Groups[i].Value));
				}
			}
		}
		return parsed;
   	}

    static public Node Parse(Node[] tokens)
    {
    	int pos = 0;  
		List<Node> children =  new List<Node>();
		while (pos < tokens.Length)
		{
			children.Add(ParseSExpr(tokens, ref pos));
			pos++;
		}  
		return new Node(Symbols.Program, children.ToArray());		
    } 

	private static Node ParseSExpr(Node[] tokens, ref int pos)
	{ 
		if (tokens[pos].Text == "(")
		{ 
			return new Node(Symbols.SExpr, ParseList(tokens, ref pos));
		} else  
		{
			return new Node(Symbols.SExpr, ParseAtom(tokens, ref pos));
		}
	}

	private static Node ParseList(Node[] tokens, ref int pos)
	{  
		List<Node> children = new List<Node>();
		children.Add(tokens[pos]);
		pos++; 

		if (tokens[pos].Text != ")")
		{ 
			children.Add(ParseSeq(tokens, ref pos));
		}
		children.Add(tokens[pos]);
		return new Node(Symbols.List, children.ToArray());
	}
	private static Node ParseSeq(Node[] tokens, ref int pos)
	{
		List<Node> children = new List<Node>();
		children.Add(ParseSExpr(tokens, ref pos));
		pos++; 
		if (tokens[pos].Text != ")")
		{ 
			children.Add(ParseSeq(tokens, ref pos));
		}
		return new Node(Symbols.Seq, children.ToArray());
	} 

	private static Node ParseAtom(Node[] tokens, ref int pos)
	{
		return new Node(Symbols.Atom, tokens[pos]);
	} 
    static private void CheckString(string lispcode)
    {
       	try
        {

           	Console.WriteLine(new String('=', 50));
            Console.Write("Input: ");
            Console.WriteLine(lispcode);
			 
            Console.WriteLine(new String('-', 50)); 
            Node[] tokens = Tokenize(lispcode).ToArray();
            Console.WriteLine("Tokens");
            Console.WriteLine(new String('-', 50)); 
            foreach (Node node in tokens)
            {
               	System.Console.WriteLine($"{node.Symbol, -20} : {node.Text, 0}");
            }
 
            Console.WriteLine(new String('-', 50));
            Node parseTree = Parse(tokens); 
            Console.WriteLine("Parse Tree");

            Console.WriteLine(new String('-', 50)); 
            parseTree.Print(); 
            Console.WriteLine(new String('-', 50));
        }
        catch (Exception)
        { 
           	Console.WriteLine("Threw an exception on invalid input.");
       	}
   	}
    public static void Main(string[] args)
    {
       	//Here are some strings to test on in 
       	//your debugger. You should comment 
       	//them out before submitting!
        	
		//CheckString(@"(define foo 3)");
        //CheckString(@"(define foo ""bananas"")");
        //CheckString(@"(define foo ""Say \\""Chease!\\"" "")");
        //CheckString(@"(define foo ""Say \\""Chease!\\)");
        //CheckString(@"(+ 3 4)");      
        //CheckString(@"(+ 3.14 (* 4 7))");
        //CheckString(@"(+ 3.14 (* 4 7)");

       	CheckString(Console.In.ReadToEnd());
    }
}



