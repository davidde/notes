# Entity Framework
## Structure of the new solution
* Class Library project `Model.csproj`:
  ```xml
  <Project Sdk="Microsoft.NET.Sdk">
    <PropertyGroup>
      <TargetFramework>net7.0</TargetFramework>
      <ImplicitUsings>enable</ImplicitUsings>
      <Nullable>enable</Nullable>
    </PropertyGroup>

    <ItemGroup>
      <Folder Include="Entities\" />
      <Folder Include="Migrations\" />
      <Folder Include="Repositories\Configurations\" />
      <Folder Include="Repositories\Seedings\" />
      <Folder Include="Services\" />
    </ItemGroup>

    <ItemGroup>
      <PackageReference Include="BCrypt.Net-Next" Version="4.0.3" />
      <PackageReference Include="Microsoft.Data.Sqlite" Version="7.0.4" />
      <PackageReference Include="Microsoft.EntityFrameworkCore" Version="7.0.4" />
      <PackageReference Include="Microsoft.EntityFrameworkCore.Abstractions" Version="7.0.4" />
      <PackageReference Include="Microsoft.EntityFrameworkCore.InMemory" Version="7.0.4" />
      <PackageReference Include="Microsoft.EntityFrameworkCore.Proxies" Version="7.0.4" />
      <PackageReference Include="Microsoft.EntityFrameworkCore.Sqlite" Version="7.0.4" />
      <PackageReference Include="Microsoft.EntityFrameworkCore.SqlServer" Version="7.0.4" />
      <PackageReference Include="Microsoft.EntityFrameworkCore.Tools" Version="7.0.4">
      <PrivateAssets>all</PrivateAssets>
      <IncludeAssets>runtime; build; native; contentfiles; analyzers; buildtransitive</IncludeAssets>
      </PackageReference>
      <PackageReference Include="Microsoft.Extensions.Configuration.Json" Version="7.0.0" />
      <PackageReference Include="MySql.EntityFrameworkCore" Version="7.0.0" />
      <PackageReference Include="System.Configuration.ConfigurationManager" Version="7.0.0" />
    </ItemGroup>

    <ItemGroup>
      <None Update="appsettings.json">
        <CopyToOutputDirectory>Always</CopyToOutputDirectory>
      </None>
    </ItemGroup>
  </Project>
  ```
* NuGet packages:

| Function              | Package Manager Console Command                                               |
|-----------------------|-------------------------------------------------------------------------------|
| EF                    | Install-Package Microsoft.EntityFrameworkCore -ProjectName Model |
|                       | Install-Package Microsoft.EntityFrameworkCore.Tools -ProjectName Model |
| SQLServer             | Install-Package Microsoft.EntityFrameworkCore.SqlServer -ProjectName Model |
| MySql                 | Install-Package MySql.EntityFrameworkCore -ProjectName Model |
| Configuration         | Install-Package System.Configuration.ConfigurationManager -ProjectName Model |
|                       | Install-Package Microsoft.Extensions.Configuration.Json -ProjectName Model |
| TDD                   | Install-Package Microsoft.Data.Sqlite -ProjectName Model |
|                       | Install-Package Microsoft.EntityFrameworkCore.Sqlite -ProjectName Model |
|                       | Install-Package Microsoft.EntityFrameworkCore.InMemory -ProjectName Model |
| Lazy Loading          | Install-Package Microsoft.EntityFrameworkCore.Proxies -ProjectName Model |
|                       | Install-Package Microsoft.EntityFrameworkCore.Abstractions -ProjectName Model |
| Security              | Install-Package BCrypt.Net-Next -ProjectName Model |

* `appsettings.json` (Copy to Output Directory: Copy Always):
  ```json
  {
    "ConnectionStrings": {
      "efproject": "Server=.\\sqlexpress;Database=EFProject;Trusted_Connection=True;TrustServerCertificate=true",
      // "efproject": "Server=.\\sqlexpress2022;Database=EFProject;Trusted_Connection=True;TrustServerCertificate=true",
      "andereconnectie": "Server=myServer;Database=myDb2;Trusted_Connection=True;"
    }
  }
  ```

## Migration
| CommandType    | PMC/CLI Command |
|----------------|----------------------------------------------------------------------------|
| Add            | `Add-Migration -Name Initial -Context xxxContext -Project Model -StartupProject Model -OutputDir "Migrations"` |
|                | `dotnet ef migrations add Initial --context xxxContext --project C:\Users\Admin\source\repo\EFProject\Model` |
| Remove         | `Remove-Migration -Context xxxContext -Project Model -StartupProject Model` |
|                | `dotnet ef migrations remove --context xxxContext --project C:\Users\Admin\source\repo\EFProject\Model` |
| Script         | `Script-Migration -Context xxxContext -Project Model -StartupProject Model` |
|                | `dotnet ef migrations script --context xxxContext --project C:\Users\Admin\source\repo\EFProject\Model` |
| Update (Up)    | `Update-Database -Context xxxContext -Project Model -StartupProject Model -verbose` |
|                | `dotnet ef database update --context xxxContext --project C:\Users\Admin\source\repo\EFProject\Model` |
| Update (Down)  | `Update-Database <migrationName> -Context xxxContext -Project Model -StartupProject Model -verbose` |
|                | `dotnet ef database update <migrationName> --context xxxContext --project C:\Users\Admin\source\repo\EFProject\Model` |

To revert the database to the initial state before the first migration:
- `Update-Database -Migration 0 -Context xxxContext -Project Model -StartupProject Model -verbose`
- `dotnet ef database update 0 --context xxxContext --project C:\Users\Admin\source\repo\EFProject\Model`

| NOTE |
|------|
| <ul><li> The first option requires `Microsoft.EntityFrameworkCore.Tools` to be installed in the project with NuGet.</li> <li>The second option requires the dotnet tool to be installed: `dotnet tool install --global dotnet-ef`.</li></ul> |

