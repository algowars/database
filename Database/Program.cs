using System.Reflection;
using DbUp;

string connectionString =
    args.FirstOrDefault() ?? throw new ArgumentException("Connection string required");

bool runBootstrap = args.Contains("--init");
bool runFixtures = args.Contains("--dev");

var assembly = Assembly.GetExecutingAssembly();

string[] allResources = assembly.GetManifestResourceNames();
Console.WriteLine("All embedded resources:");
foreach (string res in allResources)
{
    Console.WriteLine(res);
}

var schemaScripts = allResources.Where(r => r.Contains(".Schema."));
var referenceScripts = allResources.Where(r => r.Contains(".Reference."));
var systemScripts = allResources.Where(r => r.Contains(".System."));

Console.WriteLine("\nSchema Scripts:");
foreach (string? s in schemaScripts)
{
    Console.WriteLine(s);
}

Console.WriteLine("\nReference Scripts:");
foreach (string? s in referenceScripts)
{
    Console.WriteLine(s);
}

Console.WriteLine("\nSystem Scripts:");
foreach (string? s in systemScripts)
{
    Console.WriteLine(s);
}

var upgraderBuilder = DeployChanges
    .To.PostgresqlDatabase(connectionString)
    .LogToConsole()
    .WithScriptsEmbeddedInAssembly(
        assembly,
        s => s.Contains(".Schema.") || s.Contains(".Reference.") || s.Contains(".System.")
    );

if (runBootstrap)
{
    upgraderBuilder = upgraderBuilder.WithScriptsEmbeddedInAssembly(
        assembly,
        s => s.Contains(".Bootstrap.")
    );
}

if (runFixtures)
{
    upgraderBuilder = upgraderBuilder.WithScriptsEmbeddedInAssembly(
        assembly,
        s => s.Contains(".Fixtures.Dev.")
    );
}

var upgrader = upgraderBuilder.Build();

var result = upgrader.PerformUpgrade();

if (!result.Successful)
{
    Console.ForegroundColor = ConsoleColor.Red;
    Console.WriteLine(result.Error);
    Console.ResetColor();
    return -1;
}

Console.ForegroundColor = ConsoleColor.Green;
Console.WriteLine("Success!");
Console.ResetColor();
return 0;
