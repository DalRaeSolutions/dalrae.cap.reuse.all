# Reuse

## The setup

To reuse an application, you'll first need an application. If your app is already added to an NPM registry, you're good to go and you can skip to part 2: Adding the CAP app. If you're just following along to see how it works, these steps are for you. 

First I prepared a 'base' app and structured it like this:

```
| cap-demos
| -- base
| ---- /srv/
| ---- /db/
| ---- /app/
| ---- .cdsrc.json
| ---- package.json
```

To use a local app as an npm package, we can use npm itself to create a tarball for us, like so:

```
npm pack base
```

You'll then find a `.tgz` file in your `cap-demos` folder with a filename based on the name and version in your `package.json`. 
In my case, that was `reuse-base-1.0.0.tgz`. Then, we create a new application from `cap-demos`:

```
mkdir import && cd import && cds init
```

This will take us here:

```
| cap-demos
| -- reuse-base-1.0.0.tgz
| -- base
| ---- /srv/
| ---- /db/
| ---- /app/
| ---- .cdsrc.json
| ---- package.json
| -- import
| ---- /srv/
| ---- /db/
| ---- /app/
| ---- .cdsrc.json
| ---- package.json
```

## Adding an existing CAP app

To import an existing CAP application, you use npm like any other:

```
npm install my-cap-app
```

or if you have a local file:

```
npm install ../reuse-base-1.0.0.tgz
```

Your package.json file will reflect this:

```
  "dependencies": {
    "@sap/cds": "^5",
    "express": "^4",
    "reuse-base": "file:../reuse-base-1.0.0.tgz"
  },
```

After this, the base CAP app can be referred to by its name in the dependencies section. 

## Using the existing CAP app

If you start your new CAP application with `cds watch`, you'll notice there are no entities and you'll be greeted with the usual:

```
[cds] - model loaded from 2 file(s):

  ./db/schema.cds
  ./srv/orders.service.cds
```

You can now use any database entity or service entity from the imported application.

### Using entities from the schema

Usually in a node application, a package is required or imported by name. That is no difference with using CAP:

```
// in schema.cds
using from 'reuse-base/db/schema';
```

You'll immediately notice that the existing app is loaded. If you're using `cds watch`, the base csv applications are also used to populate 
the database.

```
cds] - model loaded from 4 file(s):

  ./db/schema.cds
  ./srv/orders.service.cds
  ./node_modules/reuse-base/db/schema.cds
  ./node_modules/@sap/cds/common.cds
```

## Things that work and do not work