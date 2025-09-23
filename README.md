# AlbanianXrm.CDSProj.Sdk

A visual studio sdk project based on the Microsoft provided .cdsproj project with support for Plugin Package dependencies. This project can be part of a Visual Studio solution and can be opened on visual studio

To use this just reference the Sdk using a specific version and the build system should get the definition from NuGet.

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="AlbanianXrm.CDSProj.Sdk/1.0.2">
	<ItemGroup>
		<ProjectReference Include="..\AlbanianXrm.OtherPluginPackage\AlbanianXrm.OtherPluginPackage.csproj" />
		<ProjectReference Include="..\AlbanianXrm.PluginPackage\AlbanianXrm.PluginPackage.csproj" />
		<ProjectReference Include="..\AlbanianXrm.LinearInputPCF\AlbanianXrm.LinearInputPCF.pcfproj" />
	</ItemGroup>

</Project>
```
The projects are able to load in a visual studio solution.

<img width="958" height="516" alt="AlbanianXrm CDSProj Sdk in Visual Studio" src="https://github.com/user-attachments/assets/8228cd10-fd19-4f15-bd22-c07b49a6335e" />

# AlbanianXrm.PCFProj.Sdk

A visual studio sdk project based on the Microsoft provided .pcfproj project. This project can be part of a Visual Studio solution and can be opened on visual studio.

To use this just reference the Sdk using a specific version and the build system should get the definition from NuGet.

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="AlbanianXrm.PCFProj.Sdk/1.0.1">
</Project>
```

