import fs from 'fs/promises';
import path from 'path';
import handlebars from 'handlebars';
import transporter from '../config/mailer.js';



async function generateEmailHtml(templateName, data) {
    try {
        const templatePath = path.join(process.cwd(), 'templates', 'emails', `${templateName}.html`);
        const source = await fs.readFile(templatePath, 'utf-8');
        const template = handlebars.compile(source);
        return template(data);
    } catch (error) {
        console.error(`Errore nel caricamento del template ${templateName}:`, error);
        throw new Error('Template email non trovato');
    }
}

async function sendMail({ to, subject, body }) {
    try {
        const info = await transporter.sendMail({
            from: '"reSea Official" <' + process.env.SMTP_USERNAME + '>',
            to,
            subject,
            html: body
        });
        console.log('Email inviata con successo: ' + info.messageId);
        return info;
    } catch (error) {
        console.error('Errore nell\'invio della mail:', error);
        throw error;
    }
}

export { sendMail, generateEmailHtml };