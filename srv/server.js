const cds = require('@sap/cds');
const { dirname } = require('path')
const express = require('express');

const orders_app = dirname(require.resolve("reuse-base/app/webapp/index.html"));

cds.on("bootstrap", async (app) => {
  app.use("/orders/webapp", express.static(orders_app));
});

module.exports = cds.server;