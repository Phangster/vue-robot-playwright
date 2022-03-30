import random
import string
import cv2
import numpy as np
import urllib.request as ur


__version__ = '1.0.0'


class CustomLib(object):
    ROBOT_LIBRARY_VERSION = __version__
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def get_random_name(self, email_length):
        letters = string.ascii_lowercase[:12]
        return ''.join(random.choice(letters) for i in range(email_length))

    def generate_random_emails(self, length):

        domains = ["hotmail.com", "gmail.com", "aol.com",
                   "mail.com", "mail.kz", "yahoo.com"]

        return [self.get_random_name(length)
                + '@'
                + random.choice(domains)]

    def url_to_image(self, url):
        resp = ur.urlopen(url)
        image = np.asarray(bytearray(resp.read()), dtype="uint8")
        image = cv2.imdecode(image, cv2.IMREAD_COLOR)

        # f = open('/Users/bryanphang/Desktop/test_01.png','wb')
        # f.write(ur.urlopen(url).read())
        # f.close()
 
        return image
    
    def decode_qrcode(self, path):
        # img = self.url_to_image(path)
        image = cv2.imread('tests/e2e/lib/test_qr.png', 0)

        # cv2.imshow("Image", image)
        # cv2.waitKey(0)
        # cv2.destroyAllWindows()

        qrCodeDetector = cv2.QRCodeDetector()
        decodedText, points, _ = qrCodeDetector.detectAndDecode(image)
        
        if points is not None:

            nrOfPoints = len(points)
        
            for i in range(nrOfPoints):
                nextPointIndex = (i+1) % nrOfPoints
                cv2.line(image, tuple(points[i][0]), tuple(points[nextPointIndex][0]), (255,0,0), 5)
        
            print(decodedText)    
            
            cv2.imshow("Image", image)
            cv2.waitKey(0)
            cv2.destroyAllWindows()

            return decodedText
            
        else:
            return "NO QRCODE FOUND"


        qrCodeDetector = cv2.QRCodeDetector()
        
        decodedText, points, _ = qrCodeDetector.detectAndDecode(image)

        # Remove redundant dimensions - points.shape is (1, 4, 2), and we want it to be (4, 2)
        # The first dimension may be above 1 when there are multiple QR codes (not sure about it).
        points = points[0]
        
        if points is not None:
        
            #nrOfPoints = len(points)
            nrOfPoints = points.shape[0]
        
            for i in range(nrOfPoints):
                nextPointIndex = (i+1) % nrOfPoints
                cv2.line(image, tuple(points[i, :].astype('int32')), tuple(points[nextPointIndex, :].astype('int32')), (255,0,0), 5)
        
            # print(decodedText)
        
            cv2.imshow('image', image) #cv2_imshow(image)
            cv2.waitKey(0)
            cv2.destroyAllWindows()

            return decodedText

        else:
            return "QR code not detected"