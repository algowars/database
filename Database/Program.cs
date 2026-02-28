using System;
using System.Linq;
using System.Reflection;
using DbUp;
using DbUp.Engine;
using DbUp.Helpers;

string connectionString =
    args.FirstOrDefault() ?? throw new ArgumentException("Connection string required");

bool runBootstrap = args.Contains("--init");
bool runFixtures = args.Contains("--dev");

var assembly = Assembly.GetExecutingAssembly();

var upgraderSchema = DeployChanges
    .To.PostgresqlDatabase(connectionString)
    .LogToConsole()
    .WithScriptsEmbeddedInAssembly(assembly, s => s.Contains(".Schema."))
    .Build();

var resultSchema = upgraderSchema.PerformUpgrade();

if (!resultSchema.Successful)
{
    Console.ForegroundColor = ConsoleColor.Red;
    Console.WriteLine(resultSchema.Error);
    Console.ResetColor();
    return -1;
}

var upgraderReference = DeployChanges
    .To.PostgresqlDatabase(connectionString)
    .LogToConsole()
    .JournalTo(new NullJournal())
    .WithScriptsEmbeddedInAssembly(assembly, s => s.Contains(".Reference."))
    .Build();

var resultReference = upgraderReference.PerformUpgrade();

if (!resultReference.Successful)
{
    Console.ForegroundColor = ConsoleColor.Red;
    Console.WriteLine(resultReference.Error);
    Console.ResetColor();
    return -1;
}

var upgraderSystem = DeployChanges
    .To.PostgresqlDatabase(connectionString)
    .LogToConsole()
    .JournalTo(new NullJournal())
    .WithScriptsEmbeddedInAssembly(assembly, s => s.Contains(".System."))
    .Build();

var resultSystem = upgraderSystem.PerformUpgrade();

if (!resultSystem.Successful)
{
    Console.ForegroundColor = ConsoleColor.Red;
    Console.WriteLine(resultSystem.Error);
    Console.ResetColor();
    return -1;
}

if (runBootstrap)
{
    var upgraderBootstrap = DeployChanges
        .To.PostgresqlDatabase(connectionString)
        .LogToConsole()
        .JournalTo(new NullJournal())
        .WithScriptsEmbeddedInAssembly(assembly, s => s.Contains(".Bootstrap."))
        .Build();

    var resultBootstrap = upgraderBootstrap.PerformUpgrade();

    if (!resultBootstrap.Successful)
    {
        Console.ForegroundColor = ConsoleColor.Red;
        Console.WriteLine(resultBootstrap.Error);
        Console.ResetColor();
        return -1;
    }
}

if (runFixtures)
{
    var upgraderFixtures = DeployChanges
        .To.PostgresqlDatabase(connectionString)
        .LogToConsole()
        .JournalTo(new NullJournal())
        .WithScriptsEmbeddedInAssembly(assembly, s => s.Contains(".Fixtures.dev."))
        .Build();

    var resultFixtures = upgraderFixtures.PerformUpgrade();

    if (!resultFixtures.Successful)
    {
        Console.ForegroundColor = ConsoleColor.Red;
        Console.WriteLine(resultFixtures.Error);
        Console.ResetColor();
        return -1;
    }
}

Console.ForegroundColor = ConsoleColor.Green;
Console.WriteLine("Success!");
Console.ResetColor();
return 0;
