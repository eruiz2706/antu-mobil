
class Config{

    bool _desarrollo = true;
    urlBaseApi() {
        return this._desarrollo? '192.168.1.75:8000':'api_antu.com.co';
    }
}