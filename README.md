# AlbanianXrm.CDSProj.Sdk

A visual studio sdk project based on the Microsoft provided .cdsproj project with support for Plugin Package dependencies. This project can be part of a Visual Studio solution and can be opened on visual studio

To use this just reference the Sdk using a specific version and the build system should get the definition from NuGet.

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="AlbanianXrm.CDSProj.Sdk/1.0.7">
</Project>
```

Reference your plugin packages and PCFs normally using ProjectReference tags.

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="AlbanianXrm.CDSProj.Sdk/1.0.7">
	<ItemGroup>
		<ProjectReference Include="..\AlbanianXrm.OtherPluginPackage\AlbanianXrm.OtherPluginPackage.csproj" />
		<ProjectReference Include="..\AlbanianXrm.PluginPackage\AlbanianXrm.PluginPackage.csproj" />
		<ProjectReference Include="..\AlbanianXrm.YetAnotherPluginPackage\AlbanianXrm.YetAnotherPluginPackage.csproj">
			<ManagedIdentityId>50d2aee4-08c4-4f5d-bb9b-9ce93923da42</ManagedIdentityId>
		</ProjectReference>
		<ProjectReference Include="..\AlbanianXrm.LinearInputPCF\AlbanianXrm.LinearInputPCF.pcfproj" />
	</ItemGroup>
</Project>
```

The version of the packaged solution and plugins will be read in the `solution.xml` file if the `FileVersion` property is not specified during build.

If you want to use [Managed Identities](https://learn.microsoft.com/en-us/power-platform/admin/set-up-managed-identity) then specify the `ManagedIdentityId` property in your plugin package project or in the `ProjectReference`. 
There is a target that makes sure that the `pluginpackage.xml` is properly regenerated on build.

The projects are able to load in a visual studio solution.

<img width="958" height="516" alt="AlbanianXrm CDSProj Sdk in Visual Studio" src="https://github.com/user-attachments/assets/8228cd10-fd19-4f15-bd22-c07b49a6335e" />

## Acknowledgement 
The Plugin Package support has been added based on the solution presented by [Micheal Ochs](https://www.linkedin.com/in/mikefactorial/) in the following blog post:
https://mikefactorial.com/2025/02/17/building-plugin-packages-in-ci-cd-automation/

The solution has been improved to make it generic and support multiple Plugin Package projects.

# AlbanianXrm.PCFProj.Sdk

A visual studio sdk project based on the Microsoft provided .pcfproj project. This project can be part of a Visual Studio solution and can be opened on visual studio.

To use this just reference the Sdk using a specific version and the build system should get the definition from NuGet.

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="AlbanianXrm.PCFProj.Sdk/1.0.1">
</Project>
```

