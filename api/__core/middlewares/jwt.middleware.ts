import jwt from 'jsonwebtoken';
// import { getAwsSecrets } from '../services/aws.service';
import { isEmpty } from '../utils/methods.util';
import { decrypt } from '../utils/crypto.util';
import { statuses } from '../const/api-statuses.const';
import { envVars } from '../const/config.const';

export const isAuthenticated = async (req: any, res: any, next: any) => {
    try {
        const authHeader = req.headers["authorization"];
        if (!authHeader) {
            return res.status(401).json(statuses["10020"]);
        }
            
        const token = authHeader.split(" ")[1];
        if (!token) {
            return res.status(401).json(statuses["10020"]);
        }
        // const secrets = await getAwsSecrets();
        
        const decryptedToken = decrypt(token, envVars?.HASH_KEY as string)
        if(!decryptedToken) {
            return res.status(401).json(statuses["10020"]);
        }

        if(isEmpty(envVars?.JWT_SECRET)) {
            return res.status(401).json(statuses["10010"]);
        }

        jwt.verify(decryptedToken, envVars?.JWT_SECRET as string, (err: any, decoded: any) => {
            if (err) {
                return res.status(401).json(statuses["10020"]);
            }
            req.user = decoded;
        
            next();
        });
    } catch (error) {
        return res.status(401).json(statuses["10020"]);
    }
}

