async function decodeQr(image) {
  console.log(image);
  /* eslint-disable arrow-parens */
  /* eslint-disable no-underscore-dangle */
  // eslint-disable-next-line import/no-import-module-exports
  // eslint-disable-next-line global-require
  const ZXingBrowser = require('@zxing/library');
  // eslint-disable-next-line global-require
  const codeReader = new ZXingBrowser.BrowserQRCodeReader();
  const resultImage = await codeReader.decodeFromImageUrl(image);
  return resultImage;
}
exports.__esModule = true;
exports.decodeQr = decodeQr;

async function myGoToKeyword(pageUrl, page) {
  await page.goto(pageUrl);
  return page.title();
}
exports.__esModule = true;
exports.myGoToKeyword = myGoToKeyword;
