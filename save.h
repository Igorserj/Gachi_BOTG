#ifndef SAVE_H
#define SAVE_H

#include <QObject>
#include <QVariantList>

namespace Kambiz { namespace Asadzadeh { namespace JSON {

class Save;
class Save : public QObject
{
  Q_OBJECT
  Q_PROPERTY(QVariantList  data    READ data     WRITE setData     NOTIFY dataChanged)
  Q_PROPERTY(bool          result  READ result   WRITE setResult   NOTIFY resultChanged)
  Q_PROPERTY(int           length  READ length   WRITE setLength   NOTIFY lengthChanged)

public:
  Save();

  QVariantList data () const;
  bool result       () const;
  int  length       () const;
  Q_INVOKABLE bool fileExists(QString path);
  Q_INVOKABLE void parse(QString path, QString type);
  Q_INVOKABLE void writeSettings(QString path, bool shOn, bool fullScreen, int windowWidth, int windowHeight);
  Q_INVOKABLE void writeLocal(QString path, QString seed, QString side, int floor, QString level1Finished, int currentRoom, double playerHealth, double playerMaxHealth);

  //SLOTS
public slots:
  void setData(const QVariantList& data);
  void setResult(bool result);
  void setLength(int length);

  //SIGNALS
signals:
  void dataChanged(const QVariantList& data);
  void resultChanged(bool result);
  void lengthChanged(int length);

private:
  QVariantList  m_data;
  bool          m_result = {false};
  int           m_length = {0};
};
} } }

#endif
