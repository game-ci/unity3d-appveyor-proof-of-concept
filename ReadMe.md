# Appveyor Unity3d proof of concept

[![Build status](https://ci.appveyor.com/api/projects/status/kg8s04110g6ddj5y?svg=true)](https://ci.appveyor.com/project/GabLeRoux/unity3d-encrypted-appveyor-poc)

This is a proof of concept for using [Microsoft's Unity Setup Powershell Module](https://github.com/microsoft/unitysetup.powershell) to install and run [Unity](https://unity.com) in [Appveyor CI](https://www.appveyor.com) to build and test a Unity project :tada:

This project is very similar to what I already did with gitlab-ci:

* https://gitlab.com/gableroux/unity3d-gitlab-ci-example
* https://gitlab.com/gableroux/unity3d

More details on [game.ci](https://game.ci)

## Project status

It's actually working! :tada:

Once I get [UWP working](https://github.com/GabLeRoux/unity3d-encrypted-appveyor-poc/issues/5), I will probably try to bring these scripts in [gableroux/unity3d-gitlab-ci-example](https://gitlab.com/gableroux/unity3d-gitlab-ci-example) configured as shell (powershell) runners

## Motivations

* Get the cloud to build a `UWP` (Universal Windows Platform) Unity project and/or other windows only targets using a CI
* [Appveyor CI](https://www.appveyor.com) runs on windows so it's a better fit to reach more unity components (even tho I wish they were linux compatible meh)

## Want to get in touch?

Come say hi on [GameCI's discord server](https://game.ci/discord)

## License

[MIT](LICENSE.md) © [Gabriel Le Breton](https://gableroux.com)
