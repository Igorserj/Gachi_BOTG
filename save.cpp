#include "save.h"

#include <QDir>
#include <QIODevice>
#include <QFile>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QVariantList>
#include <stdio.h>
#include <QTextStream>
#include <QDataStream>

using namespace Kambiz::Asadzadeh::JSON;

QJsonDocument document;
QJsonObject jsonObject;
QVariantMap modelData;
QString rawData;

Save::Save() {}

bool Save::fileExists(QString path) {
    QFileInfo check_file(path);
    if (check_file.exists() && check_file.isFile()) {
        return true;
    } else {
        return false;
    }
}

QVariantList Save::data() const
{
    return m_data;
}

void Save::setData(const QVariantList& data)
{
    if (m_data == data)
        return;
    m_data = data;
    emit dataChanged(m_data);
}

int Save::length() const { return m_length; }
void Save::setLength(int length) { if (m_length == length) return; m_length = length; emit lengthChanged(m_length); }

bool Save::result() const { return m_result; }
void Save::setResult(bool result) { if (m_result == result) return; m_result = result; emit resultChanged(m_result); }

void Save::parse(QString path, QString type) {
    QFile file1(path);
    QVariantList finalJson;
    if (!file1.open(QIODevice::ReadOnly | QIODevice::Text)){
        qCritical() << "hui";
        return;
    }
    rawData = file1.readAll();
    file1.close();
    QJsonDocument document   =   { QJsonDocument::fromJson(rawData.toUtf8()) };
    QJsonObject jsonObject = document.object();
    setLength(jsonObject["model"].toArray().count());
    if (type=="settings") {
        foreach (const QJsonValue &value, jsonObject["model"].toArray()) {
            // Sets value from model as Json object
            QJsonObject modelObject = value.toObject();
            modelData.insert("shOn", modelObject["shOn"].toBool());
            modelData.insert("fullScreen", modelObject["fullScreen"].toBool());
            modelData.insert("windowWidth", modelObject["windowWidth"].toInt());
            modelData.insert("windowHeight", modelObject["windowHeight"].toInt());
        }
    }
    else if (type == "local") {
        foreach (const QJsonValue &value, jsonObject["model"].toArray()) {
            QJsonObject modelObject = value.toObject();
            modelData.insert("seed", modelObject["seed"].toString());
            modelData.insert("side", modelObject["side"].toString());
            modelData.insert("floor", modelObject["floor"].toInt());
            modelData.insert("currentRoom", modelObject["currentRoom"].toInt());
            modelData.insert("playerHealth", modelObject["playerHealth"].toDouble());
            modelData.insert("playerMaxHealth", modelObject["playerMaxHealth"].toDouble());
            modelData.insert("level1Finished", modelObject["level1Finished"].toString());

//            foreach (const QJsonValue &value, jsonObject["level1Finished"].toArray()) {
////                QJsonArray level1FinishedArray = value.toArray();
//                modelData.insert("level1Finished", value["level1Finished"].toArray());
//            }
        }
    }
        // Set model data
        finalJson.append(modelData);
    // Sets data
    setData(finalJson);
    // Sets result by status object of model.
    setResult(jsonObject["result"].toBool());
    file1.close();
}

void Save::writeSettings(QString path, bool shOn, bool fullScreen, int windowWidth, int windowHeight) {
    QFile file2(path);
    if (!file2.open(QIODevice::WriteOnly)){
        qCritical() << "hui";
        return;
    }
    QJsonObject recordObject;
    QJsonObject modelObject;
    QJsonArray modelArray;
    modelObject.insert("shOn", shOn);
    modelObject.insert("fullScreen", fullScreen);
    modelObject.insert("windowWidth", windowWidth);
    modelObject.insert("windowHeight", windowHeight);
    modelArray.push_back(modelObject);
    recordObject.insert("model", modelArray);
    recordObject.insert("result", true);

    QJsonDocument document(recordObject);
    qDebug() << document.toJson();
    file2.write(QByteArray(document.toJson()));
    file2.flush();
    file2.close();
}

void Save::writeLocal(QString path, QString seed, QString side, int floor, QString level1Finished, int currentRoom, double playerHealth, double playerMaxHealth) {
    QFile file2(path);
    if (!file2.open(QIODevice::WriteOnly)){
        qCritical() << "hui";
        return;
    }
    QJsonObject recordObject;
    QJsonObject modelObject;
    QJsonArray modelArray;
//    QJsonArray level1FinishedArray;
    modelObject.insert("seed", seed);
    modelObject.insert("side", side);
    modelObject.insert("floor", floor);
    modelObject.insert("level1Finished", level1Finished);
    modelObject.insert("currentRoom", currentRoom);
    modelObject.insert("playerHealth", playerHealth);
    modelObject.insert("playerMaxHealth", playerMaxHealth);
//    modelObject.insert("level1Finished", level1Finished);
    modelArray.push_back(modelObject);
//    level1FinishedArray.push_back(level1Finished.toJsonArray());
    recordObject.insert("model", modelArray);
    recordObject.insert("result", true);

    QJsonDocument document(recordObject);
    qDebug() << document.toJson();
    file2.write(QByteArray(document.toJson()));
    file2.flush();
    file2.close();
}





