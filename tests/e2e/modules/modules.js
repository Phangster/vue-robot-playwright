/* eslint-disable global-require */
/* eslint-disable no-bitwise */
/* eslint-disable max-len */
function scanQR(base64) {
  const {
    MultiFormatReader,
    BarcodeFormat,
    DecodeHintType,
    RGBLuminanceSource,
    BinaryBitmap,
    HybridBinarizer,
  } = require('@zxing/library');

  const { PNG } = require('pngjs');

  const rawImageData = PNG.sync.read(Buffer.from(base64.split(';base64,')[1], 'base64'));

  const hints = new Map();
  const formats = [BarcodeFormat.QR_CODE, BarcodeFormat.DATA_MATRIX];

  hints.set(DecodeHintType.POSSIBLE_FORMATS, formats);
  hints.set(DecodeHintType.TRY_HARDER, true);

  const reader = new MultiFormatReader();

  reader.setHints(hints);

  const len = rawImageData.width * rawImageData.height;

  const luminancesUint8Array = new Uint8ClampedArray(len);
  for (let i = 0; i < len; i += 1) {
    luminancesUint8Array[i] = ((rawImageData.data[i * 4] + rawImageData.data[i * 4 + 1] * 2 + rawImageData.data[i * 4 + 2]) / 4) & 0xFF;
  }

  const luminanceSource = new RGBLuminanceSource(luminancesUint8Array, rawImageData.width, rawImageData.height);

  const binaryBitmap = new BinaryBitmap(new HybridBinarizer(luminanceSource));

  const qrCode = reader.decode(binaryBitmap);

  if (qrCode) {
    return qrCode.getText();
  }
  return '';
}

async function decodeQr(image) {
  /* eslint-disable arrow-parens */
  /* eslint-disable no-underscore-dangle */
  // eslint-disable-next-line import/no-import-module-exports
  // eslint-disable-next-line global-require
  // const splitedBase64 = image.split(';base64,')[1];
  const test = scanQR(image);
  return test;
  // const jsdom = require('jsdom');
  // const { JSDOM } = jsdom;
  // global.document = new JSDOM().window.document;
  // const img2 = document.createElement('img');
  // img2.src = image;

  // const ZXingBrowser = require('@zxing/browser');
  // // eslint-disable-next-line global-require
  // const codeReader = new ZXingBrowser.BrowserQRCodeReader();
  // const resultImage = await codeReader.decodeFromImageElement(img2);
  // return resultImage;
}
exports.__esModule = true;
exports.decodeQr = decodeQr;

async function myGoToKeyword(pageUrl, page) {
  await page.goto(pageUrl);
  return page.title();
}
exports.__esModule = true;
exports.myGoToKeyword = myGoToKeyword;
