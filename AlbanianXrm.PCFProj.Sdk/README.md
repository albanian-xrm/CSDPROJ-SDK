# AlbanianXrm.PCFProj.Sdk

A visual studio sdk project based on the Microsoft provided .pcfproj project. This project can be part of a Visual Studio solution and can be opened on visual studio.

To use this just reference the Sdk using a specific version and the build system should get the definition from NuGet.

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="AlbanianXrm.PCFProj.Sdk/1.0.0">
  <PropertyGroup>
    <ProjectGuid>7a3744cb-7515-47e3-ad37-3edf2a49b115</ProjectGuid>
  </PropertyGroup>
</Project>
```