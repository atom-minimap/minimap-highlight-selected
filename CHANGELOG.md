<a name="4.6.1"></a>
# 4.6.1 (2017-01-12)

## :sparkles: Features

- check for available decorators before disposing

<a name="4.6.0"></a>
# 4.6.0 (2017-01-12)

## :sparkles: Features

- Update to new highlight-selected API

<a name="4.5.0"></a>
# 4.5.0 (2017-01-12)

## :sparkles: Features

- Add ability for consuming selected words ([7db133ed](https://github.com/atom-minimap/minimap-highlight-selected/commit/7db133ed85c2f2abef844a52ff11007a6ad8819a))

## :bug: Bug Fixes

- Fix method context when used as listeners ([0733c890](https://github.com/atom-minimap/minimap-highlight-selected/commit/0733c8908618f535869bf5b6ef2ed79258784672))

<a name="v4.4.0"></a>
# v4.4.0 (2016-03-07)

## :sparkles: Features

- Add plugin origin on created decorations ([a9ea1437](https://github.com/atom-minimap/minimap-highlight-selected/commit/a9ea1437c55bb5703f390ca56dbd775bb119202c))

<a name="v4.3.1"></a>
# v4.3.1 (2015-09-22)

## :arrow_up: Dependencies Update

- Bump atom-utils version ([142405e5](https://github.com/atom-minimap/minimap-highlight-selected/commit/142405e52d18a608027d0d47078ae961b5e5dbd3), [#16](https://github.com/atom-minimap/minimap-highlight-selected/issues/16))

<a name="v4.3.0"></a>
# v4.3.0 (2015-05-27)

## :sparkles: Features

- Implement markers in selection with a different color ([305cf34a](https://github.com/atom-minimap/minimap-highlight-selected/commit/305cf34abad82eb192e9f5289853bee331482b85), [#10](https://github.com/atom-minimap/minimap-highlight-selected/issues/10))  <br>Only effective when `highlight-selected.hideHighlightOnSelectedWord`
  setting is enabled.

<a name="v4.2.3"></a>
# v4.2.3 (2015-05-11)

## :bug: Bug Fixes

- Prevent undefined from being returned in fake editor ([b078e0c1](https://github.com/atom-minimap/minimap-highlight-selected/commit/b078e0c1f555d331545ca2b4b99fa03100be8490))

<a name="v4.2.2"></a>
# v4.2.2 (2015-05-11)

## :bug: Bug Fixes

- Prevent error raised when disposing the view ([333e7d8b](https://github.com/atom-minimap/minimap-highlight-selected/commit/333e7d8bfedc0fcbe1eab42d7a35a529c1d8f03b), [richrace/highlight-selected#67](https://github.com/richrace/highlight-selected/issues/67))


<a name="v4.2.1"></a>
# v4.2.1 (2015-04-20)

## :bug: Bug Fixes

- Fix plugin broken by latest highlight-selected update ([e50a0638](https://github.com/atom-minimap/minimap-highlight-selected/commit/e50a063814321aa096dd9413dd2887255c9391e5), [#8](https://github.com/atom-minimap/minimap-highlight-selected/issues/8))


<a name="v4.2.0"></a>
# v4.2.0 (2015-03-01)

## :sparkles: Features

- Implement minimap service consumer ([2242da9f](https://github.com/atom-minimap/minimap-highlight-selected/commit/2242da9f644dcde9b3483835b27f994e8ef91ec1))

<a name="v4.1.0"></a>
# v4.1.0 (2015-02-22)

## :truck: Migration

- Migrate to atom-minimap organization ([2d10fd61](https://github.com/atom-minimap/minimap-highlight-selected/commit/2d10fd61a0a078eab08da8aa87a640f79c81e955))


<a name="v4.0.0"></a>
# v4.0.0 (2015-02-03)

This version enable exclusive support for Minimap v4.

## :bug: Bug Fixes

- Fix error raised on tab close ([cd7f93c3](https://github.com/atom-minimap/minimap-highlight-selected/commit/cd7f93c3ff84ee78f38974402d7dea37ba477aed))
- Fix broken plugin since highlight-selected update ([de7b38b2](https://github.com/atom-minimap/minimap-highlight-selected/commit/de7b38b2be40172ff6c4f3cd62aa39a54b0b31e4), [#5](https://github.com/atom-minimap/minimap-highlight-selected/issues/5))

<a name="v3.1.2"></a>
# v3.1.2 (2015-01-26)

## :bug: Bug Fixes

- Fix deprecations ([4c903462](https://github.com/atom-minimap/minimap-highlight-selected/commit/4c90346280e32065fbde0dd1291c7473b35e57e5))

<a name="v3.1.1"></a>
# v3.1.1 (2015-01-26)

## :bug: Bug Fixes

- Fix error raised when minimap is not toggled ([148f5732](https://github.com/atom-minimap/minimap-highlight-selected/commit/148f5732bb5009e39508bd2ceb1fadb0e45af3a8), [#4](https://github.com/atom-minimap/minimap-highlight-selected/issues/4))

<a name="v3.1.0"></a>
# v3.1.0 (2015-01-05)

## :sparkles: Features

- Implement support for both minimap v3 and v4 API ([dc01e08d](https://github.com/atom-minimap/minimap-highlight-selected/commit/dc01e08de819c184effc75df75827480229260bf))

## :bug: Bug Fixes

- Fix error raised when typing in a mini editor ([3d78a2f8](https://github.com/atom-minimap/minimap-highlight-selected/commit/3d78a2f89d57ef29557b44bcc1608243a5133270))

<a name="v3.0.0"></a>
# v3.0.0 (2014-09-19)

## :sparkles: Features

- Add version test for minimap v3 ([49ed7f84](https://github.com/atom-minimap/minimap-highlight-selected/commit/49ed7f84e1319bcfb9504fb9d63436bee0d7241b))
- Implement support for new minimap decoration API ([a31a2d50](https://github.com/atom-minimap/minimap-highlight-selected/commit/a31a2d509c5e2899a40fff8c8bffd6c50feebe2c))

## :bug: Bug Fixes

- Fix deprecated minimap methods calls ([d63a773d](https://github.com/atom-minimap/minimap-highlight-selected/commit/d63a773d0de54809721bedc31be81c33a64ae831))
- Fix plugin not destroying/recreating markers on activation ([96bc3af0](https://github.com/atom-minimap/minimap-highlight-selected/commit/96bc3af0c20bebeef94eb708cb65fa00a0fc4666))

<a name="v1.0.2"></a>
# v1.0.2 (2014-08-17)

## :bug: Bug Fixes

- Fix broken plugin with highlight-selected@0.5.0 ([a96d2afb](https://github.com/atom-minimap/minimap-highlight-selected/commit/a96d2afb3b82737be6d0edd8f56fe7b53ce5ee4f))

<a name="v1.0.1"></a>
# v1.0.1 (2014-08-17)

## :bug: Bug Fixes

- Fix toggling plugin doesn't remove or recreate views ([9a931710](https://github.com/atom-minimap/minimap-highlight-selected/commit/9a931710b46842429785c604d8c03d2ea42ed36f))

<a name="v1.0.0"></a>
# v1.0.0 (2014-08-16)

## :sparkles: Features

- Implement support for the minimap position API ([36debca3](https://github.com/atom-minimap/minimap-highlight-selected/commit/36debca3cb5356d739d0b05165c183e5d9c1aa5a))

<a name="v0.3.0"></a>
# v0.3.0 (2014-07-10)

## :sparkles: Features

- Implement using a syntax variable for highlights ([16af2f91](https://github.com/atom-minimap/minimap-highlight-selected/commit/16af2f91373e30e35f1e7b77e2fd9ba2e424abb1), [#2](https://github.com/atom-minimap/minimap-highlight-selected/issues/2))


<a name="v0.2.0"></a>
# v0.2.0 (2014-07-07)

## :sparkles: Features

- Add compatibility for upcoming react support in minimap ([76f683d9](https://github.com/atom-minimap/minimap-highlight-selected/commit/76f683d98962dad1e0024de99c37c08cae654ccf))


<a name="v0.1.1"></a>
# v0.1.1 (2014-05-02)

## :bug: Bug Fixes

- Fixes screenshot path ([7e43ad8c](https://github.com/atom-minimap/minimap-highlight-selected/commit/7e43ad8ce217362b22043ecaf4767a0a8e47ea41))


<a name="v0.1.0"></a>
# v0.1.0 (2014-05-02)

## :sparkles: Features

- Adds screenshots and documentation ([30c22042](https://github.com/atom-minimap/minimap-highlight-selected/commit/30c220420fa7106fcd39750429b100b31e5e7147))
