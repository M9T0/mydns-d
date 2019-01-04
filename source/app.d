import std.stdio;
import std.datetime;
import core.thread;
import dyaml;

import requests;

static immutable Duration sleepDuration = dur!"days"(1);

void main()
{
    Node root = Loader.fromFile("conf.yaml").load();
    while(true) {
        auto lastTime = Clock.currTime;
        writeln(lastTime);

        auto rq = Request();
        auto user = root["user"].get!string;
        auto pass = root["password"].get!string;
        rq.authenticator = new BasicAuthentication(user, pass);
        auto rs = rq.get( "http://www.mydns.jp/login.html");
        writeln(rs.responseBody);

        auto now = Clock.currTime;
        auto delta = now - lastTime;
        auto wait = sleepDuration - delta;
        Thread.sleep(wait);
    }
}
